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

# for performance this book through 

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
## Variables
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

a = 1
a


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
## Types 
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


### 
# Boolean
false
true

# get the type 
typeof(false)

###
# Numeric Types

## Integer
# Integer is Int64 by default in 64-bit architecture 
# and Int32 in 32-bit architecture
1

# `ans` returns the last evaluated value 
typeof(ans)

# `versioninfo()` return the version and platform
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



###
# Strings


# get type 





#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
## Basic arithmetic and statistic functions
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


## basic arithmetic functions +, -, *, /

2 + 3.2
2 - 3.1
+(3,4)
+(5,7,8) == 5 + 7 + 8
2 - 3.1 == -1.1

#BEWARE!
2.0 - 3.2 == -1.2

3 * 2
3 / 2
*(4,5)
/(4,5)

sqrt(9)
log(10)
log(e)
log(pi)
log(π)
exp(2)

*("Hello ", "world")


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
"""
Exercise: Guess the result and type of the following commands, then evaluate
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
2/1
div(2,1)
/("Hello ", "world")
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/(5,1.4)
# floor division
fld(5,1.4)


# numeric literal
x = 5
2x
3x + 4(x-5)
(3x)x





# cor() find the Pearson correlation
# cov() find the covariance
# mean()  find the mean of an array
# std() find the standard deviation of an array
# var() find the variance
# median()  find the median

# `srand()` sets random seed number





#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Vectors and Arrays
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


## initialization

#zeros
vFloat = zeros(100)

# as integer
vInt = zeros(Int64,100)

# as Bool
vBool = zeros(Bool,100)

#ones 


## Vectorization


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Control Flow 
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-




#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Functions
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#apropos() to search documentation


# Basic for loop construction


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



## Statistical tools


# Integrating
# type `;` to switch to shell

## Integrating with R

# PyCall

## Performance tips and parallel computing