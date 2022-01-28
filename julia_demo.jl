#=
Basic demo to Julia

Ignacio Quintero Mächler

t(-_-t)
=#


#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Multiple dispatch and performance comparison
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#

f(λ::Float64) = 2.0λ
f(0.3)

f(λ::Int64) = div(λ,2)
f(4)

fp(λ::Float64) = println("$λ is a Float")
fp(λ::Int64)   = println("$λ is a Int64")
fp(λ::Int64, y::Int64) = λ + y

fp(1.0)
fp(1)
fp(1,3)


@code_warntype fp(1,3)

## parametric multiple dispatch
# set the same type for arguments
function sum_same_type(x::T, y::T) where {T}
  x + y
end

# it works if arguments have the same type
sum_same_type(1, 2)
sum_same_type(1.0, 2.0)


f(x, y, z) = x + y + z

@code_warntype f(1.0, 1, 2)

#= 
 we can also combine both parametric methods
this is powerful: it is flexible yet it allows
the compiler to know the result type and dimension
=#
function elem_sum(x::Array{T,N}, y::Array{T,N}) where {T<:Number, N}
  s = Array{T,N}(undef, size(x))
  for i in eachindex(x)
    s[i] =  x[i] + y[i]
  end
  return s
end

# for one dimensional vectors
x = [1,2,3]
elem_sum(x,x)

# for matrices
r0 = rand(10,10)
r1 = rand(10,10)
elem_sum(r0,r1)



#=
let's compare the benchmark of a normal density evaluation and 
a normal random generator with R (which is an immediate call to C )
=#

# load package that integrates with R
using RCall

# in R
reval("""
      if (!any("microbenchmark" == rownames(installed.packages()))) {
        install.packages('microbenchmark')
      }
      library(microbenchmark)
      microbenchmark(
        dnorm(1.0, 0.5, 1.0, TRUE),
        rnorm(1L, 0.5, 2.0)
      )
      """)

# define normal log-density
logdnorm(x::Float64, μ::Float64, σ²::Float64) = 
  -(0.5*log(2.0π) + 0.5*log(σ²) + (x - μ)^2/(2.0σ²))

# define generator for non-standard normal
rnorm(μ::Float64, σ::Float64) = μ + randn()*σ

# load benchmarking package
using BenchmarkTools

@benchmark logdnorm(1.0, 0.5, 1.0)
@benchmark rnorm(0.5, 1.0)



#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Basic Parallel computing
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#

# load Julia's native package for parallelism
using Distributed

# how many workers?
workers()

# add and remove workers 
addprocs(3)

# check
workers()

# post loop aggregation, here summing over the result
n1 = @distributed (+) for i in 1:10_000
  rand(0:1)
end



#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
A tiny bit of Meta Programming
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#


#=
Let's look at a more advanced example with `@generated` functions
from actual useful functions

Let's create an simple approximating function from an ordered vector x, and 
a function y = f(x).
=#

## Let's create some random data to create a function y = f(x)
# `x` is a sorted vector (e.g., time)
x = cumsum(rand(100))
x[1] = 0.0

# `y` is 4 `parallel` multivariate functions under Brownian motion
y = randn(100, 4)
y[1,:] .= 0.0
cumsum!(y, y, dims = 1)

# plot the functions
using Plots

plot(x,y)

#=
First we need a linear interpolation function
=#

"""
    linpred(val::Float64, x1::Float64, x2::Float64, y1::Float64, y2::Float64)

Estimate `val` according to linear interpolation for a range.
"""
linpred(val::Float64, x1::Float64, x2::Float64, y1::Float64, y2::Float64) = 
  (y1 + (val - x1)*(y2 - y1)/(x2 - x1))


# example
val = x[2] - rand()*x[2]
linpred(val, x[1], x[2], y[1,1], y[2,1])

#= 
Second create an efficient index searcher for a sorted vector
=#

"""
    idxrange(x::Array{Float64,1}, val::Float64)

Get indexes in sorted vector `x` corresponding to the range in which 
`val` is in using a sort of uniroot algorithm.
"""
function idxrange(x::Array{Float64,1}, val::Float64)

  @inbounds begin

    a::Int64 = 1

    if x[a] > val
      return a, false
    end

    b::Int64 = lastindex(x)

    if x[b] < val
      return b, false
    end

    mid::Int64 = div(b,2)

    while b-a > 1
      val < x[mid] ? b = mid : a = mid
      mid = div(b + a, 2)
    end

    if x[a] == val 
      return a, false
    elseif x[b] == val
      return b, false
    else
      return a, true
    end
  end
end


# example: returns the closer left index in x to the value
idx, inside = idxrange(x, 20.)
x[idx]
x[idx+1]

# this is efficient
@benchmark idxrange($x, 22.)


# Non-meta programmed function using loops to evaluate y at time t
function approxf_full_std!(t ::Float64,
                           r ::Array{Float64,1},
                           x ::Array{Float64,1}, 
                           y ::Array{Float64,N},
                           nc::Int64) where {N}

  @inbounds begin
    a, lp = idxrange(x, t)::Tuple{Int64, Bool}

    if lp
      xa = x[a]::Float64
      xap1 = x[a + 1]::Float64
      for i = Base.OneTo(nc)
        r[i] = linpred(t, xa, xap1, y[a, i], y[a + 1, i])::Float64
      end
    else
        r[i] = y[a, i]::Float64
    end
  end

  return nothing
end


## Now let's make a meta program that does not loop through each of the 
# y columns

# We need to define some arguments that will go into the function (see later)
N  = ndims(y)
nc = size(y,2)

# start the Expr
lex1 = quote end
pop!(lex1.args)

# push the linear prediction and unroll
if isone(N)
  push!(lex1.args, 
    :(r[1] = linpred(t, x[a], x[a+1], y[a], y[a+1])::Float64))
else
  # unroll loop
  for i = Base.OneTo(nc)
    push!(lex1.args, 
      :(r[$i] = linpred(t, xa, xap1, y[a,$i], y[a+1, $i])::Float64))
  end

  # add one assignment
  pushfirst!(lex1.args, :(xap1 = x[a+1]::Float64))
  pushfirst!(lex1.args, :(xa   = x[a]::Float64))
end

lex2 = quote end
pop!(lex2.args)

# if the value is outside of `x` 
if isone(N)
  push!(lex2.args, :(r[1] = y[a]::Float64))
else
  # unroll loop
  for i = Base.OneTo(nc)
    push!(lex2.args, :(r[$i] = y[a,$i]::Float64))
  end
end

# join both expressions
lex = quote
  a, lp = idxrange(x, t)::Tuple{Int64, Bool}
  if lp 
    $lex1 
  else 
    $lex2 
  end
end

# aesthetic cleaning
deleteat!(lex.args,[1,3])

popfirst!(lex.args[2].args[2].args)
lex.args[2].args[2] = lex.args[2].args[2].args[1]

popfirst!(lex.args[2].args[3].args)
lex.args[2].args[3] = lex.args[2].args[3].args[1]

# let's see the final function to be evaluated
lex


#=
Now let's put it in a `@generated` function. This special awesome function
will first  generate the code, and then will only evaluate the Expression.
=#

"""
    @generated function approxf_full!(t ::Float64,
                                      r ::Array{Float64,1},
                                      x ::Array{Float64,1}, 
                                      y ::Array{Float64,N},
                                      ::Val{nc}) where {N, nc}
Returns the values of `y` at `t` using an approximation function.
"""
@generated function approxf_full!(t ::Float64,
                                  r ::Array{Float64,1},
                                  x ::Array{Float64,1}, 
                                  y ::Array{Float64,N},
                                  ::Type{Val{nc}}) where {N, nc}

  lex1 = quote end
  pop!(lex1.args)

  if isone(N)
    push!(lex1.args, 
      :(r[1] = linpred(t, x[a], x[a+1], y[a], y[a+1])::Float64))
  else
    # unroll loop
    for i = Base.OneTo(nc)
      push!(lex1.args, 
        :(r[$i] = linpred(t, xa, xap1, y[a,$i], y[a+1, $i])::Float64))
    end

    # add one assignment
    pushfirst!(lex1.args, :(xap1 = x[a+1]::Float64))
    pushfirst!(lex1.args, :(xa   = x[a]::Float64))
  end

  lex2 = quote end
  pop!(lex2.args)

  if isone(N)
    push!(lex2.args, :(r[1] = y[a]::Float64))
  else
    # unroll loop
    for i = Base.OneTo(nc)
      push!(lex2.args, :(r[$i] = y[a,$i]::Float64))
    end
  end

  lex = quote
    a, lp = idxrange(x, t)::Tuple{Int64, Bool}
    if lp 
      $lex1 
    else 
      $lex2 
    end
  end

  # aesthetic cleaning
  deleteat!(lex.args,[1,3])

  popfirst!(lex.args[2].args[2].args)
  lex.args[2].args[2] = lex.args[2].args[2].args[1]

  popfirst!(lex.args[2].args[3].args)
  lex.args[2].args[3] = lex.args[2].args[3].args[1]

  println(lex)

  return quote
    @inbounds begin
      $lex
    end
    return nothing
  end
end


# example
r = Array{Float64,1}(undef,size(y,2)) # preallocate resulting interpolation
approxf_full!(5., r, x, y, Val{size(y,2)})
r


@benchmark approxf_full!(5., $r, $x, $y, $(Val{(size(y,2))}))
@benchmark approxf_full_std!(5., $r, $x, $y, $(size(y,2)))

#=
Finally, let's compare to a similar R function that is implemented in C 
(not super-fair comparison for our function is very tailored made, but still...)
=#
@rput x
@rput y

reval("""
      require(microbenchmark)

      f = approxfun(x, y[,1L])
      r1 = f(5.0) # evaluate at 5.0

      microbenchmark(f(5.0))
      """)

# check that we get the same answer
@rget r1

r1    # R results
r[1]  # Julia result
# same answer but WAY faster!






