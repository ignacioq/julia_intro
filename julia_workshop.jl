# Introduction to Julia
# HPC Workshop, Yale University
#
# Ignacio Quintero
#
# 07/12/2017
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


# This is a comment

# great documentation:
# i.  the official: https://docs.julialang.org/en/stable/
# ii. wiki books: https://en.wikibooks.org/wiki/Introducing_Julia

# for performance this book: Julia High Performance by Avik Sengupta,
# available through the Yale library,
# but some of it is out of date.


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
## Variables
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# assign `a`
a = 1
a

# unicode names are allowed (type as in latex, preceded with `\`)
λ = 2.0
λ

# some variable are already defined
π
e

# we can redefine them, but it will give a Warining
π = true
π

# Oh-uh, let's change it back
π = Base.pi
π

# Do not use `.` in variable names, they represent `fields` in types
a.1 = 2

# you can use underscores, although discouraged if not necessary 
a_1 = 2

# some few names cannot be used for variables
else = 2
end  = "Hi"


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
## Basic Types 
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

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
false
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
x  = typemax(Int64)
x += 1

# x is now the minimum
x == typemin(Int64)

# convert between types
x = convert(Int8, 1)
typeof(x)

# or simply
Int16(1)
typeof(ans)

# `whos()` prints current global symbols
whos()

# you can use underscores to separate integers
1_000_447


## Float
# Float is Float64 by default in 64-bit architecture 
# and Float32 in 32-bit architecture
1.0
typeof(ans)

# the minimum and maximum Float type is -Inf & Inf
typemin(Float64); typemax(Float64)

# Not a Number, `NaN` is a Float64
NaN
typeof(ans)

# scientific notation is Float64 by default
1e4
typeof(ans)

# convert between Int and Float
x = convert(Int64, 1.0)
typeof(x)

Int64(1.0)

# Literal zero and one
zero(Int64)
one(Float64)


###
# Strings

# Strings are made of characters, `Char`
# Characters are delimited by single quotes
'X'
'λ'

# Strings are delimited by double quotes (or triple double quotes)
"Hi"
typeof(ans)

s = """Hello there"""

# you can subset a string and get a `Char`
s[1]
s[6]


## Create a type and hierarchy
abstract type Country end
type USA <: Country end
type Colombia <: Country end
type France <: Country end
subtypes(Country)


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
## Basic math
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


## basic math functions +, -, *, /, ^, %

# sum
2 + 3.2
2 - 3.1
+(3,4)
+(5,7,8) == 5 + 7 + 8
2 - 3.1 == -1.1

#BEWARE!
2.0 - 3.2 == -1.2

# product
3 * 2
3 / 2
*(4,5)
/(4,5)
*(2,3,5)

#power
2.3^4

#remainder
20%3
rem(20,3)

# common math functions
sqrt(9)
√9
log(10)
log(e)
log(pi)
log(π)
exp(2)


# floor division
/(5,1.4)
fld(5,1.4)

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
"$s1$s2"

# it works with inside evaluation
"1+4 = $(1+4)"



#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
"""
Exercise: 

1. Guess the result and type of the following commands, then evaluate
"""

1.0 + 1
NaN + 2.0
NaN + 2
1   + Inf
Inf - Inf
Inf * Inf
Inf * -Inf
0   * -Inf
"0" + 0
3/0
0/0
0.0 == -0.0
0   == -0.0
NaN == NaN
isequal(NaN, NaN)
Inf == Inf
2/1
2\1
div(2,1)
/("Hello ", "world")
x = 2; x ^= 4


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Vectors and Arrays
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

## vectors are delimited by suing `[` and  `]`
x = [2, 3, 5]
typeof(x) == Vector{Int64}

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
idx = [2,3]
x[idx]

# or better with UnitRange
x[2:3]
typeof(2:3)

# length and endof return the length
endof(x) == length(x)

# `end` returns the last item
x[end]

# you can assign to a subset
x[1:2] = [5,7]
x[3] = "chao"
x


## initialization
# zeros, by default Float64
v = zeros(100)

# zeros as integer
v = zeros(Int64,100)

# as Bool
v = zeros(Bool,100)

# alternatively
v = trues(100)
v = falses(100)

# ones work similarly
v = ones(100)

# start with any value
v = fill(NaN,100)
v = fill(2.447, 100)

## UnitRange and StepRange
ur = 1:100
typeof(ur)

# you can also declare UnitRanges with
colon(1,10)

# you can subset UnitRange 
ur[10]

# However you cannot assign
ur[10] = 5

# convert into vector and assign
v = collect(ur)
v[10] = 5

# StepRange construction is `start:step:end`
# Int
sr = 1:2:6
typeof(sr)
1:2:6 == colon(1,2,6)

# range construction is `start:step:length`
r = range(1,2,6)
[r...]


# you can index but not assign as with UnitRange
sr[end]
sr[2] = 1

v = collect(sr)

# also works with Floats
sr = 1.0:0.1:2.0
v = collect(sr)

# this can also be achieved with 
v = [sr...]

# linspace construction is `start:end:length`
ls = linspace(1, 100, 12)
[ls...]


## Comprehensions
# comprehensions create vectors using a loop
v = [i^2 for i in 1:10]

# you can add if statement to filter
v = [i^2 for i in 1:10 if i != 4]

# a fast vector creation 
v = Vector{Int64}(100)

# create an empty vector 
v = Int64[]
v = Any[]

# you can have vector of vectors (of vectors, of vectors...)
x = zeros(10)
v = fill(x, 5)
u = fill(v, 5)

typeof(u) == Vector{Vector{Vector{Float64}}}


## Functions on vectors

# fuse two vectors
x = [1:3...]
append!(x,[4:5...])
x

# NOTE: functions ending with `!` ("bang") changes the object in place

# add one or more elements to the end
push!(x,6)
push!(x,7,8,9)

# add one or more elements at the beggining
unshift!(x,-1,0)

# replace and insert an element at a given index (returs the replaced item)
x = [1,3,4,5,6]
splice!(x, 2, 2:3)

# splice also deletes if not provided with a replacement
splice!(x,3:4)

# remove the last element (and return it)
pop!(x)
x

# remove the first element (and return it)
shift!(x)
x

# delete at a given index
x = [1:5...]
deleteat!(x, 3)

# remove all elements
empty!(x)

# fill an existing vector with the same value
x = [1:5...]
fill!(x, 1)

# this can also be done with base assign
x = [1:5...]
x[1:5] = 1
x

# you can also use fill! to create vectors
v = fill!(Array{String}(3), "hello")


## Multi-Dimensional Arrays

# vectors are an alias of Array{T,1}
Vector{Any} == Array{Any,1}

# compare the construction
[1, 2, 3] == [1 2 3]

[1, 2, 3]

[1 2 3]

# create along dimensions
[1 2 3; 4 5 6]

# most of the above functions work for multidimensional arrays
# just add a new dimension size

# create zeros with 10 rows and 5 columns
a = zeros(10,5)

# create three-dimensional ones
a = ones(10,5,2)

# get the number of dimensions and size of each
ndims(a)
size(a)
length(a)

# fast construction
a = Array{Float64}(5,5,3)

# create identity matrix
a = eye(5)

# create diagonal matrix
a = diagm(1:5)

# repmat repeats a vector along each dimension
# repeat in dim one (rows)
repmat([1,2,3],2,1)
# repeat in dim two (cols)
repmat([1,2,3],1,2)

# 2 dimensional comprehensions
a = [i*j for i in 1:5, j in 1:5]

# 3 dimensional comprehensions
a = [i*j*h for i in 1:5, j in 1:5, h = 1:5]

# reshaping
a = [1:9...]
a = reshape(a,3,3)

## indexing along dimensions
# 1st & 2nd row, and 3 column
a[1:2,3]

# index first row
a[1,:]

# index second column
a[:,2]

# Julia supports efficient linear indexing
a[1:5]


## copying and pointers
# copy by reference
b = a
# assing to b
b[2] = 100
# it is also changed in a
a

# you can test if they share memory by using `===`
a === b

# `similar()` copies the dimensions but not the values
a[:] = 1:9
b = similar(a)
b[2] = 100
a === b
a

# shallow `copy()` copies the values as well
b = copy(a)
b[2] = 100
a === b
a

# `deepcopy()` makes a fully independent object (more on this later)
b = deepcopy(a)
b[2] = 100
a === b
a


## Vectorization
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


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
"""
Exercises: 

1. create an `Int64` identity matrix (10,10) without using `eye(10)`.
2. fill the above object such that it is now a Diagonal matrix with 1:10 
   without using `diagm()`.
3. start with this vector `[1,2,3,4,5]` and, using only `splice!()`, end up 
   `[1,4,3,2,5]`.
4. Create a Range that goes from 10 to 1 and then make a new matrix object
   with 5 rows, where each row is this range.
5. Create a 3-dimensional array of size `(5,5,3)` where each element is the 
   product of the 1d index with the 2d index elevated to the 3d index. 
6. Checkout the `filter!()` function and use it to allow only even values
   in `[1,2,3,6,7,3,1,10,28]`.
7. What is the required step size to have 16 equally spaced values between
   1.0 and 3.2?
8. What is the difference between `max()` and `maximum()`.
9. Learn how to use `setdiff()` and find the length of non shared elements
   between:
   a = [2,8,4,9]
   b = [4,2,3,5]
10. Using `find()`, equality `==`, and vectorized functions, create a vector 
    with the indices that match 1 for the following vector:
    [10,11,1,4,5,1,11,1,3,0,2,-1]
"""


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Basic statistical utilities
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# draw from the uniform distribution U(0,1)
rand()

# `srand()` sets random seed number
srand(123)
rand(100)

srand(123)
rand(100)

# make an array with random uniform numbers
rand(10,10)

# Bernoulli trials
rand(0:1)

# `rand(S)` uniformly picks a value from the collection S
S = [4,7,7]
rand(S)

# check that it is uniform pick (1/3 for 7)
x = [rand(S) for i in 1:10000]
length(filter(isodd,x))/length(x)

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

## basic statistics
x = randn(1000)

mean(x)
std(x)
var(x)
median(x)

# Pearson correlation and covariance 
y = randn(1000).*0.1
cor(x, y)
cov(x, y)

# approximate comparison
isapprox(mean(x), mean(y), atol = 0.1)


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
"""
Exercise: 

1. Estimate the standard deviation among the differences between the estimated
   mean of 1_000 randexp and 1, for 10_000 replicates. (tip: see the 
   documentation of `mean()`)
"""


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Control Flow 
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


# for loop iterators
eachindex(x)



for i in 1:10 
  println(i)
end


#Iterators
A = zeros(10,15)

for i in indices(A)
  println(i)
end


for i in indices(A,1)
  println(i)
end



#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Functions
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#apropos() to search documentation


# Basic for loop construction



## Statistical tools


# Integrating
# type `;` to switch to shell

## Integrating with R

# PyCall

## Performance tips and parallel computing