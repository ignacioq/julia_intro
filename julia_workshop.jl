# Introduction to Julia
#
# Ignacio Quintero
#
# 07/12/2017
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


# This is a comment

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
typemax(x)



typeof(1)
typeof(1.0)
typeof(true)




# typemax & typemin gives the maximum 

x = convert(Int64, 1.0)
typeof(x)

###
# Strings


# get type 





#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
## Variables
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



## Vectors and Arrays.

# initialization

#zeros
vFloat = zeros(100)

# as integer
vInt = zeros(Int64,100)

# as Bool
vBool = zeros(Bool,100)

#ones 


## Control Flow Functions and Multiple Dispatch

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

## Integrating with R

## Performance tips and parallel computing