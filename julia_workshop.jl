#=
Basic introduction to Julia

Ignacio Quintero Mächler

t(-_-t)
=#


"""
Some Documentation:
i.   the official: https://docs.julialang.org/en/v1/
ii.  wiki books: https://en.wikibooks.org/wiki/Introducing_Julia
iii. Slack: julialang.slack.com. Very active and responsive community
iv. Zulip: julialang.zulipchat.com. Very active and responsive community
v.  stack overflow...
vi.   For performance this book:
     Julia High Performance by Avik Sengupta,
     ...but some of it is out of date.


To use the REPL (Read Evaluate Print Loop) with Sublime Text

 - Cmd + Enter sends the code if the line at which the cursor is at.
 - Highlight and Cmd + Enter sends the highlighted code to the REPL
"""

# This is a comment

#=
  This
  is
  a 
  comment
  block
=#

#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Access documentation
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#

# use `apropos()` to search for matching functions
apropos("product")

# type `?` followed by the command

#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
## Variables
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#

# assign `a`
a = 1
a

# unicode names are allowed 
# (type as in latex, preceded with `\`, then hit tab)
λ = 2.0
λ
σ² = 1.2


# some variable are already defined
pi
π == pi
ℯ

# you cannot redefine them
π = Base.pi

# Do not use `.` in variable names, they represent `fields` in types
a.1 = 2

# you can use underscores, although discouraged if not necessary
a_1 = 2

# some few names cannot be used for variables
else = 2
end  = "Hi"


#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Basic Types
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#

# Types are organized in hierarchically
"""
Number -> Complex
       -> Real    -> Irrational
                  -> Rational(Integer)
                  -> Integer          -> BigInt
                                      -> Bool
                                      -> Signed -> Int128
                                                -> Int64
                                                -> ...
                                      -> Unsigned ...
                  -> AbstractFloat    -> BigFloat
                                      -> Float64
                                      -> Float32
                                      ->...
"""

###
# Numeric Types

## Boolean
true

# get the type
typeof(false)

# get the super type
supertype(Bool)

## Integer
# get the subtypes of integer
subtypes(Integer)
subtypes(Signed)

Integer <: Signed
Signed <: Integer


# Integer is Int64 by default in 64-bit architecture
# and Int32 in 32-bit architecture
1

# `ans` returns the last evaluated value
typeof(ans)

# `versioninfo()` returns the version and platform
versioninfo()

# `typemax` & `typemin` gives the maximum possible value
typemin(Int64)
typemax(Int64)

# overflow wraps
x = typemax(Int64)
x += 1

# x is now the minimum
x == typemin(Int64)

# convert between types
x = convert(Int8, 1)
typeof(x)

# or simply
Int16(1)
typeof(ans)

# `varinfo()` prints current global symbols
varinfo()

# you can use underscores to separate integers
1_000_447 == 1000447


## Float
# Float is Float64 by default in 64-bit architecture
# and Float32 in 32-bit architecture
1.0
typeof(ans)

# the minimum and maximum Float type is -Inf & Inf
typemin(Float64)
typemax(Float64)

# Not a Number, `NaN` is a Float64 by default
NaN
typeof(ans)

# there are also `NaN`s for Float32 and Float16
NaN16, NaN32

# scientific notation is Float64 by default
1e4
typeof(ans)

# convert between Int and Float (always avoid if possible)
x = convert(Int64, 1.0)
isa(x, Int64)

Int64(1.0)

# Literal zero and one
zero(Int64)
one(Float64)

###
# Strings

# Strings are made of characters, `Char`
# Characters are delimited by single quotes
'X'
typeof(ans)

'λ'
typeof(ans)

# Strings are delimited by double quotes (or triple double quotes)
"Hi"
typeof(ans)

s = """
    Hello there
    This is a Julia Workshop
    """

# you can subset a string and get a `String` or a `Char`
s[1:3]
s[6]


#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Basic math
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#

## basic math functions +, -, *, /, ^, %

# sum
2 + 3.2
2 - 3.1
+(3,4)
+(5,7,8) == 5 + 7 + 8
2 - 3.1 == -1.1

#BEWARE!
2.0 - 3.2 == -1.2
@show 2.0 - 3.2

# product
3 * 2
3 / 2
*(2,3,5)

#power
2.3^4

#remainder
20%3

# other common math functions
sqrt(9)
√9
log(10)
log(ℯ)
sin(π)
exp(2)

# numeric literal
x = 5
2x
3x + 4(x-5)
(3x)x

# comparisons
1 + 1 == 2
1 + 1 > 4
1+3 >= 4
2.01 != 2.02
-Inf < 0
-Inf < Inf
isequal(2.0, 2.0)
isinf(Inf)
isnan(NaN)

# approximate comparisons
isapprox(1.00001, 1.0, atol = 1e-5)
isapprox(1.00001, 1.0, atol = 1e-2)

# updates
x = 1
x += 1
x

x /= 0.5
x *= 0.5

# concatenate strings
*("Hello ", "world")
string("Hello ", "world")

# you can use string interpolation with `$`
s1 = "Hello "
s2 = "world"

"s1s2"

"$s1$s2"

# it works with inside evaluation
"1+4 = $(1+4)"


#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Integrating with shell, R and Python
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#

## Shell integration
# use shell within Julia by just typing `;`

# shell commands are denoted with backticks
shcom = `echo hello`
typeof(shcom)

# use run to evaluate
run(shcom)


# install any package with Pkg.add("PackageName")


## Integrating with R
# load package (you need R installed)
using RCall

# go to R by typing `$` (backspace to return to Julia)

# get a variable defined in R
R"x = 2+4"
@rget x
typeof(x)

# put a variable defined in Julia into R 
t = 10
@rput t 
R"t"

# can also check that it is in R by using `$`

# reval evaluates R code 
reval("""
      s   <- array(NA_integer_, dim=c(10,5))
      s[] <- 1:50 
      s   <- s*4
      """)

# get s
@rget s

# you can plot as well
R"plot(runif(10), runif(10), bty = 'n')"


# Similarly with Python (you need Python installed)
using PyCall
math = pyimport("math")
math.sin(math.pi / 4)

#= 
Check the packages documentation for more information
RCall:  http://juliainterop.github.io/RCall.jl/stable/
PyCall: https://github.com/JuliaPy/PyCall.jl
=#

#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Vectors and Arrays
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#

## vectors are delimited by using square brackets `[` and  `]`
x = [2, 3, 5]
isa(x, Vector{Int64})

# Vector is an alias of a one-dimensional array
Vector{Float64} == Array{Float64,1}

# vectors with at least one Float will be converted to all Floats
x = [2, 3.0, 5]

# you can force it to be integers
x = Int64[2, 3.0, 5]

# but...
x = Int64[2, 3.1, 5]

# instead
x = Float64[2, 3.1, 5]

# vectors can be of different types (not recommended)
x = [2, 3.0, "hi"]
typeof(x)

# you can subset with an Integer or Integer vector
x[1]
x[[2,3]]

# or better (more efficient) with UnitRange
x[2:3]
typeof(2:3)

#= length and lastindex return the length (lastindex do not work with 
un-indexed collections such as Dictionaries but is slightly faster)
=#
lastindex(x) == length(x)

# `end` returns the last item
x[end]

# you can assign to a subset
x[1:2] = [5,7]
x[3] = "chao"
x


## initialization

# Boolean vector
v = trues(10)

# zeros, by default Float64
v = zeros(10)

# zeros as integer
v = zeros(Int64,10)

# ones work similarly
v = ones(10)

# create a vector with any value
v = fill(NaN, 10)
v = fill("hi", 10)

## UnitRange and StepRange
ur = 1:10
typeof(ur)

# you can subset UnitRange
ur[2]

# However you cannot assign
ur[2] = 5

# convert into vector and assign
v = collect(ur)
v[10] = 5

# StepRange construction is `start:step:end`
sr = 1:2:6
typeof(sr)

#=
you can construct with `range`: it estimates the 
StepRange according to the number of objects and the step size
=#
1:2:6 == range(1, step=2, length=3)

# also works with Floats
sr = 1.0:0.1:2.0

# transform into a vector
v = collect(sr)

# this can also be achieved with
[sr...] == v


## Comprehensions
# comprehensions create vectors using a loop
v = [i^2 for i in 1:10]

# you can add if statement to filter (conditional comprehensions)
v = [i^2 for i in 1:10 if i != 4]

# a fast (undefined) vector creation
v = Vector{Int64}(undef, 20)

# create an empty vector
v = Int64[]
v = Any[]

# you can have vector of vectors (of vectors, of vectors, ...)
x = zeros(10)
v = fill(x, 5)
u = fill(v, 5)

isa(u, Vector{Vector{Vector{Float64}}})


## Functions on vectors
# fuse two vectors
x = [1:3...]
append!(x, 4:5)
x

"""
NOTE: functions ending with `!` ("bang") change the object in place
"""

# add one or more elements to the end
push!(x,6)
push!(x,7,8,9)

# add one or more elements at the beggining
pushfirst!(x,-1,0)

# replace and insert an element at a given index (returns the replaced item)
x = [1,3,4,5,6]
splice!(x, 2, 2:3)

# splice also deletes if not provided with a replacement
splice!(x,3:4)
x

# remove the last element (and return it)
pop!(x)
x

# remove the first element (and return it)
popfirst!(x)
x

# delete at a given index
x = [1:5...]
deleteat!(x, 3)

# remove all elements
empty!(x)

# fill an existing vector with the same value
x = [1:5...]
fill!(x, 1)

# this can also be done with base assign but
# you need the period `.` ahead, for broadcasting, more on that later.
x = [1:5...]
x[1:5] .= 1
x

# you can also use fill! to create vectors
v = fill!(Array{String}(undef, 3), "hello")

# which seems to be as fast as:
v = fill("hello", 3)


## Multi-Dimensional Arrays

# compare the construction
[1, 2, 3] == [1 2 3]

[1, 2, 3]

[1 2 3]

# create along second dimensions
[1 2 3; 4 5 6]

# Matrix is an alias for a two-dimensional Array
Matrix{Any} == Array{Any,2}

# most of the above functions work for multidimensional arrays
# just add a new dimension size

# create zeros with 10 rows and 5 columns
A = zeros(10,5)

# create three-dimensional ones
A = ones(10,5,2)

# get the number of dimensions and size of each
ndims(A)
size(A)
length(A)

# fast construction (again)
A = Array{Float64}(undef,5,5,3)

# repeat a vector along each dimension
# repeat twice in dim one (rows)
repeat([1,2,3],2,1)
# repeat in dim two (cols)
repeat([1,2,3],1,2)

# 2 dimensional comprehensions
A = [i*j for i in 1:5, j in 1:5]

# 3 dimensional comprehensions
A = [i*j*h for i in 1:5, j in 1:5, h = 1:5]

# reshaping
v = [1:9...]
A = reshape(v,3,3)

## indexing along dimensions
# 1st & 2nd row, and 3 column
A[1:2,3]

# index first row
A[1,:]

# index second column
A[:,2]

# Julia supports efficient linear indexing
A[1:5]


## copying and pointers
# copy by reference
B = A
# assigning to b
B[2] = 100
# it is also changed in a
A

# you can test if they share memory by using `===`
A === B

# `similar()` copies the dimensions but not the values
A[:] = 1:9
B = similar(A)
B[2] = 100
A === B
A

# shallow `copy()` copies the values as well
B = copy(A)
B[2] = 100
A === B
A

# `deepcopy()` makes a fully independent object, including substructures 
# (important for `struct`)
B = deepcopy(A)
B[2] = 100
A === B
A

# for efficiency, you can copy to an already existent array
B[1] = 100
B
copyto!(B, A)
B


## Dictionaries
# Dictionaries directionally associate two objects `key => value`,
# they are not ordered
d = Dict("a" => 1, "b" => 2, "c" => 3)
typeof(ans)

# look up by key
d["a"]

# cannot look up by value...
d[1]

# can add new elements
d["d"] = 4
d

# Dictionaries can accommodate almost any object
using Random

d = Dict("unif" => rand(10),
         "norm" => randn(10),
         "exp"  => randexp(10))
d["unif"]

d = Dict([1,0,0] => "one",
         [0,1,0] => "two",
         [0,0,1] => "three")
d[[0,1,0]]

# Create a Dictionary using comprehensions
d = Dict("r$i" => randn() for i = 1:10)

# get allows you to returns another value if the key is not found
get(d, "r1", NaN)
get(d, "hi", NaN)


# Sets
# Sets are like arrays but without duplicated elements
Set([1,1,0])
typeof(ans)

## Tuples
# Tuples are like arrays but cannot be modified, they are immutable
t = (1,2,4)
typeof(t)

# you cannot modify them
t[1] = 2

# convert a tuple into an array
a = [t...]

# re convert back to tuple
t = (a...,)


## Vectorization (broadcasting)
# Julia allows vectorization, as in R,
# however, I find it less efficient and avoidable
x = [1:10...]
y = [1:10...]

z = x + y

# for clarity (and consistency) is better to use the `dot` syntax
z = x .+ y

z = x .* y

# in functions
cos.(z)
log.(z)



#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Basic statistical and linear algebra utilities
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#

# draw from the uniform distribution U(0,1)
rand()

# `Random.seed!()` sets random seed number
Random.seed!(123)
rand(10)

Random.seed!(123)
rand(10)

# make an array with random uniform numbers
rand(10,10)

# Bernoulli trials with p = 0.5
rand(0:1)

# `rand(S)` uniformly picks a value from the collection S
S = [4,7,7]
rand(S)

# you can create a random string with
randstring(10)

# check that it is uniform pick (1/3 for 4)
x = [rand(S) for i in 1:100_000]

using Statistics

mean(isodd, x)

# draw from the Normal distribution N(0,1)
randn()

# create an array of Normal draws
x = randn(10,5)

# fill with new values
randn!(x)

# draw from Exponential(1.0)
randexp()

# permute an integer vector of some length
randperm(10)

# permute a given vector
v = randperm(10)
shuffle!(v)

## basic statistics in library `Statistics`
x = randn(10000)

mean(x)
std(x)
var(x)
median(x)
sum(x)
prod(x)

# these functions usually allow to provide a function
# before aggregating
mean(exp, x)
mean(exp.(x))

# Pearson correlation and covariance
y = randn(10_000) .* 0.1
cor(x, y)
cov(x, y)

# approximate comparison
isapprox(mean(x), mean(y), atol = 0.1)

## Matrix Functions
A = rand(10,10)

# scalar sum
A .+ 1.0

# scalar product
2.0A

# load library for Linear Algebra
using LinearAlgebra

# change in place
rmul!(A, 2.0)

# matrix sum
B = ones(10,10)
A + B

# matrix product
A * B
*(A,B)

# matrix inverse
inv(A)

# matrix determinant
det(A)

# reshape matrix dimensions
A = reshape([1:9...],3,3)


# Julia allows you to specify certain characteristics of Matrices to
# handle them more efficiently (e.g.,Symmetric, UpperTriangular,
# Diagonal, etc.)
B = [1 2 -3.0;
     2 5  0.1;
     -3.0 0.1 -2]
B = Symmetric(B)

# more efficient for certain operations, such as
B/1.5

# Note: Julia has the very efficient BLAS functions incorporated in Base
# for instance, `axpy!(s,X,Y)` performs `s*X + Y` and overwrites in Y
A = rand(5,5)
B = ones(5,5)
axpy!(2.0, A, B)
B



"""
Exercises 01
"""



#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Composite types (struct)
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#

# create a simple book structure
struct Book
  title ::String
  author::String
  year  ::Int64
end

# get fieldnames 
fieldnames(Book)

# construct one instance
A = Book("The Aeneid", "Virgil", -19)

# get title
A.title
getproperty(A, :title)

# change title
A.title = "Aeneid"

# with mutable structures we can now modify the structure
mutable struct Dog
  name  ::String
  age   ::Int64
  weigth::Float64
end


N = Dog("Nicanor", 7, 45.3)

# for instance, when it is his anniversary 
N.age += 1

# get new age
N.age



#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Control Flow
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#

## if conditional
x = 5
if x > 4
  println("hello")
end

# variables defined within if statements are available in the outer scope
if x > 4
  y = 1
end
y

# if returns a value
r = if x > 3
      "$x is greater than 3"
    elseif x == 3
      "$x is 3"
    else
      "$x is smaller than 3"
    end

# ternery operators (concise if else statement)
x = 3; y = 1

x > y ? "$x is greater than $y" : "$x is smaller than $y"

# AND and OR
x > 0 && y < 10

x > 0 || y < 10

x > 10 && y < 10

# one can link comparisons
x > y < 10 < 11

# `&&` can be used as a concise `if` statement
x > y && println("$x is greater than $y")

# similarly, for `if not` use `||`
x < y || println("x is not greater than y")


## loops
# for loops (you can use `in` or `=`)
for i in 1:10
  println(i)
end

"""
A quick note on scoping:

Scoping rules are relatively intuitive, but since Julia >= 1.5, 
loops do not allow modifying global variables except when in the REPL.
"""

# for instance, this works but is not recommended
j = 0
for i in 1:5
  j += i
end
#=
because the loop does not search for variables in the global scope.
This is for efficiency (avoiding global variable definitions is, 
overall, better coding) and follows "good" coding standards.
=#

# However, loops do allow modification to the parent scope as long as is local:
for j in 1:2
  j = 0
  for i in 1:5
    j += i
    println((j, i))
  end
end

#=
To allow the efficient modification of global variables there are two options, 
surround in a `let` block, such like
=#
let j = 0
  for i in 1:5
    j += i
  end
  println(j)
end

#=
or declare that the variable is actually global, and now the loop
will look for global variables.
=#
j = 0
for i in 1:5
  global j += i
end
println(j)

#=
so just, for illustration, in the following loops we have included the global
keyword for the REPL, but is not needed unless within a local scope.
=#

# while loops
i = 1
while i <= 10
  println(i)
  global i += 1
end

# break to stop the loop
i = 1
while true
  println(i)
  global i += 1
  i > 10 && break
end

# continue for skipping to the next iteration
for i = 1:10
  i == 5 && continue
  println(i)
end

# nested loops
for j in 1:5
  for i in 1:5
   println("The product between $i and $j is $(i*j)")
  end
end

# a more concise syntax
for j in 1:5, i in 1:5
  println("i -> ",i," and j -> ", j)
end

# NOTE: with string, it is more efficient to not use the interpolation `$` when
# concatenating strings
s = "hola"
# this is better
*(s, " gente")
# than this
"$s gente"

# iterate over a collection
S = [1, 10, NaN]
for s in S
  println(s)
end

# iterate over array (note the `∈` == `in` == `=` in loops)
A = rand(5, 5)
s = 0.0
for i ∈ A
  global s += i
end
sum(A) == s


## common iterators
# iterate for the length of a vector
v = ["a","b","c"]
for i = eachindex(v)
  println(i)
end

# create a tuple with the iteration and the value of `v`
for i = enumerate(v)
  println(i)
end

# assign the iteration and the value in the loop
for (i,v) = enumerate(v)
  println(i, v)
end

# Most efficient loop if looping over a `UnitRange` that starts at `1`
for i = Base.OneTo(10)
  println(i)
end

# `enumerate()` is a great way to create a Dictionary
d = Dict(i => v for (i,v) in enumerate(v))

# iterate over dictionary keys
for k in keys(d)
  println(k+1)
end

# iterate over dictionary values
for val in values(d)
  println(val)
end

# iterating over dictionary return tuple of (key, value)
for (k,v) in d
  println(k, " is the key of ", v)
end

# iterating over Matrices
A = zeros(5,3)
for j in axes(A,2), i in axes(A,1)
  println("row = ",i, "; col = ", j)
end

#= 
Performance note for iterating over Array:

Since memory access is recorded in linear order, such as:, 

1 4 7
2 5 8
3 6 9

it's more efficient to iterate over arrays with the outer loop 
corresponding to the highest dimension and then go to the 
lowest dimensions in order (as in the example above, 
we iterate first over rows first `i` and then columns `j`, thus 
accessing items in the memory order).
=#


#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Functions & multiple dispatch
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#

# basic construction
function f(x)
  x + x
end
f(2)

# This is equivalent
f(x) = x + x
f(4)

# return function
function f(x)
  if x > 0
    return x * x
  else
    return x + x
  end
end

f(4)
f(-4)

# `dot` syntax for a function (vectorizing it). I do not recommend it, 
# do not be afraid of loops!
f.(-3:3)

# z will not be defined in the outer scope
function f(x)
  z = 1
  x + z
end
f(2)
z

# but already defined variables can be changed
function fill_with_ones!(x)
  x[:] .= 1
  return nothing
end

x = zeros(10)
fill_with_ones!(x)
x

#=
arguments are "passed-by-sharing", that is, they are referenced,
not copied (close to zero overhead); always better to pass multiple
arguments than matching from the outer scope.
=#

# this is BAD
k = 10
function fbad(x)
  x + k
end

fbad(10)

# this is good :)!
function fgood(x, k)
  x + k
end

fgood(10, 10)

#######
# Parenthesis: Evaluating Performance
fbad(x)    = x + k
fgood(x,k) = x + k

# the first time is not representative of the speed
@time fbad(10)
@time fgood(10, 10)

# the second time runs fully compiled function
@time fbad(10)
@time fgood(10, 10)

# time is too small, repeating several times gives a better estimate
@time for i in 1:10_000 fbad(10) end
@time for i in 1:10_000 fgood(10, 10) end

# BenchmarkTools Package makes this easy
using BenchmarkTools

# benchmark repeats the evaluation 10_000 times by default (beware
# time consuming evaluations) and returns time statistics
@benchmark fbad(10)
@benchmark fgood(10, 10)

# `scaped` parts to not be included in the performance evaluation with `$`
f(x) = sum(x)
@benchmark f([1,2,3,4,5])
@benchmark f($[1,2,3,4,5])
# here we escape the creation and allocation of the vector so 
# it is only evaluating the sum of the vector.

# let's compare the benchmark of a normal density evaluation and 
# a normal random generator with R (which is an immediate call to C )

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

@benchmark logdnorm(1.0, 0.5, 1.0)
@benchmark rnorm(0.5, 1.0)

#######


## anonymous functions
# the syntax is: `input` -> `return`
x -> x + 10

# can be used on several functions, such as
# map function
map(x -> x + 10, 0:0.1:1)

# you can use any predefined function
map(cos, 0:π/4:2π)

# for more than one argument, use a tuple
map((x,y) -> x + y, [1:10...], [2:11...])



### Multiple dispatch
# Multiple dispatch allow you to define different functions
# based on the type and number of arguments (also on the value, an example later)
# this is efficient, up to a point
fp(x::Float64) = println("$x is a Float")
fp(x::Int64)   = println("$x is a Int64")
fp(x::Int64, y::Int64) = x + y

fp(1.0)
fp(1)
fp(1,3)

# no method for Int8 though
fp(Int8(1))

# you can check the methods of a function with `methods()`
methods(fp)

# let's explore the methods from a Base function
methods(randn)

# this is great for "Type Stability"
divide(n::Int64, d::Int64) = div(n,d) # between integers
divide(n::Float64, d::Float64) = n/d  # between floats


## parametric multiple dispatch
# set the same type for arguments
function sum_same_type(x::T, y::T) where {T}
  x + y
end

# it works if arguments have the same type
sum_same_type(1, 1)
sum_same_type(1.0, 1.0)

# but throws an error not if they are of different types
sum_same_type(1.0, 1)

# we might want to restrict the type to be numeric since...
sum_same_type("1","1")

function sum_number(x::T, y::T) where {T<:Number}
  x + y
end

# numeric types of the same type work
sum_number(1, 1)

# but no method for Strings
sum_number("1", "1")

# let's create a method for strings (this is a bit of inefficient
# meta-programming)
function sum_number(x::String, y::String)
  eval(Meta.parse(*(x, "+", y)))
end

# now we have a method for strings
sum_number("1", "1")

# one can also have methods for different array dimensions
# (notice the preallocation within the function)
function elem_prod(x::Array{Float64,N}, y::Array{Float64,N}) where {N}
  s = Array{Float64,N}(undef,size(x))
  for i in eachindex(x)
    s[i] = x[i] * y[i]
  end
  return s
end

# this works
elem_prod([1.0,2.0,3.0], [1.0,2.0,3.0])

# and this (note that these are Matrices)
elem_prod([1.0 2.0 3.0], [1.0 2.0 3.0])

# but this doesn't
elem_prod([1.0,2.0,3.0], [1.0 2.0 3.0])


# we can also combine both parametric methods
# this is powerful: it is flexible yet it allows
# the compiler to know the result type and dimension
function elem_sum(x::Array{T,N}, y::Array{T,N}) where {T<:Number, N}
  s = Array{T,N}(undef, size(x))
  for i in eachindex(x)
    s[i] =  x[i] + y[i]
  end
  return s
end

# for one dimensional vectors
elem_sum([1,2,3],[1,2,3])

# for matrices
elem_sum(rand(10,10),zeros(10,10))

# multiple dispatch with values
function fval(x::Int64, ::Val{1})
  (x + 10)/2
end

function fval(x::Int64, ::Val{2})
  (x + 10)^2
end

# to evaluate, you need `Val{}` again
x = 1
y = 2
fval(5, Val(x))
fval(5, Val(y))

# Arguments are passed in order
function prodsum(x, y, z)
  x + y*z
end

prodsum(1,2,3)

# this does not work
prodsum(1, z = 3, y = 2)

# Keyword arguments are optional arguments and are matched by name
# we can use keywords
function prodsum(x; y = 1, z = 2)
  x + y*z
end

prodsum(2)
prodsum(2, y = 3)
prodsum(2, y = 3, z = 5)

#=
Don't go crazy with keyword arguments because there is a slight 
overhead to perform the matching.
=#

# multiple return values (easy! and no almost no overhead)
function sum_prod(x::Array{Float64,N}) where {N}
  return sum(x), prod(x)
end

# it is now tuple
sum_prod(rand(10))

# you can assign by order
sum_x, prod_x = sum_prod(rand(10))

@show sum_x
@show prod_x



"""
Exercises 02
"""







#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Statistical tools and DataFrames
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#

#=
Check out JuliaStats, a large group of packages for 
Statistics
http://juliastats.github.io
=#

## Pkg.add("Distributions")
using Distributions

# Define a Normal with mean 3.0 and standard deviation 1.5
gauss = Normal(3.0, 1.5)

# `fieldnames()` gives the appropriate parameters
fieldnames(typeof(gauss))

# 10 random samples
rand(gauss,10)

# define a Binomial with 5 trials and p = 0.2
binom = Binomial(5, 0.2)

# random variable
rand(binom, 10)

# there are many other univariate distributions:
# https://juliastats.github.io/Distributions.jl/latest/univariate.html

# get quantiles 
quantile.(gauss, [0.025, 0.5, 0.975])

# fast fitting of a distribution, which creates a new
# distribution Type (using MLE by default)
gfit = fit(Normal, rand(gauss, 10))

## Statistics evaluation
mean(gfit)
var(gfit)
quantile.(gfit, [0.1, 0.9])
mode(gfit)
entropy(gfit)
minimum(gfit)
# there other descriptive statistics...


## Probability evaluation

# probability density function (pdf)
lik = pdf.(gfit, [2.0,3.4,1.3])

# log pdf
loglik = logpdf.(gfit, [2.0,3.4,1.3])

# total log likelihood
loglikelihood(gfit,[2.0,3.4,1.3])

# NOTE: I personally create my own simplified and problem-tailored 
# PDFs in logarithmic space for likelihood evaluation as I found them 
# to be much faster

# cumulative density function
cdf(gfit, 3.)

# you can truncate any distribution
tcau = Truncated(Cauchy(), 0.0, Inf)

# check that it is truncated
cdf(tcau, 0.0)
cdf(Cauchy(), 0.0)

## Multivariate Distributions
mvmean = [1.0,2.0,1.5]
Σ      = [1.0 0.2 0.9;
          0.2 1.0 0.5;
          0.9 0.5 1.0]

mvn = MvNormal(mvmean,Σ)

# most functions for univariate distributions 
# work for multivariate distributions
logpdf(mvn, [1.1,2.1,1.1])
rand(mvn,10)

# additional functions such as
# Mahalanobis distance 
sqmahal(mvn, [.1,2.1,1.1])


# You can also construct Mixture-Models
mixd = MixtureModel(Normal,                               # if all are normals
                   [(-2.0, 1.2), (0.0, 1.0), (3.0, 2.5)], # parameters
                   [0.2, 0.5, 0.3])                       # prior probabilities
mean(mixd)
var(mixd)
logpdf(mixd, 0.1)


## DataFrames are similar to data.frames in R
# Pkg.add("DataFrames")
using DataFrames

## initialization
df = DataFrame(A=1:5, B=rand(5), C=randstring.([5,5,5,6,7]))
typeof(ans)

# columns types 
eltype.(eachcol(df))

# summary stats
describe(df)

# column names 
names(df)

## indexing is similar than in arrays
# columns
df[:,1]

# but also 
df[:,2]      # by number
df[:,:A]    # by name

# rows
df[4,:]

# sort rows in place
sort!(df, :B)

# unique rows (also accepts in place `unique!`)
unique(df)



#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
I/O
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#


## Basic (less streamlined)
# open a connection to the file
file = open(homedir()*"/repos/julia_intro/iris.csv")

# read all lines
lines = readlines(file)

#=
you can then loop through the lines using something like
for line in lines
  `do something`
end
=#

# you should close the connection
close(file)

# use DelimitedFiles package
using DelimitedFiles

# readdlm is a basic Array reader
readdlm(homedir()*"/repos/julia_intro/iris.csv", ',')

# `writedlm(file, array)` writes Arrays to a file.
# but we are not going to write anything here

## CSV works great with DataFrames
# Pkg.add("CSV")
using CSV

# load the (never used before) Iris Data Set (change your wd 
# to the specific directory)
iris = CSV.read(homedir()*"/repos/julia_intro/iris.csv", DataFrame)

describe(iris)
size(iris)
names(iris)

## Using JLD2 (Julia Native Format, faster)
# Pkg.add("JLD2")
using JLD2

# define some variables
x = 3.5
t = randn(2,10)

# the syntax of save is `file`, `save var with name`, `var`, ...
@save homedir()*"/repos/julia_intro/work.jld2" x t

# load variables (as dictionary)
@load "/Users/quintero/repos/julia_intro/work.jld2"


# let's remove those files from the repo
rm("/Users/quintero/repos/julia_intro/work.jld2")

#=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Basic Parallel computing
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=#

# open julia with `-p <ncores>` parameter
using Distributed

# how many workers?
workers()

# add and remove workers 
addprocs(3)

# check
workers()

# remove worker
rmprocs(4)

# check
workers()

# the `everywhere` macro ensure code is available in all processes
@everywhere using Distributions

# post loop aggregation, here summing over the result
n1 = @distributed (+) for i in 1:10_000
  rand(0:1)
end


# using SharedArrays so that all workers can access the Array
using SharedArrays
# the parallel macro and shared arrays
r = SharedArray{Float64}(1_000)
@distributed for i in 1:1_000
  r[i] = mean(fit(Normal, randn(1_000)))
end


"""
Exercises 03
"""




