#############################################################################################
#Original test script was provided on the course forum by Jules Stuifbergen. 
#I only added a few test cases to check what happens when the value of the matrix is modified.
#############################################################################################
# Test your code
#source("cachematrix.R")
#
# generate matrix, and the inverse of the matrix.
size <- 1000 # size of the matrix edge, don't make this too big
mymatrix <- matrix(rnorm(size^2), nrow=size, ncol=size)
mymatrix.inverse <- solve(mymatrix)

mymatrix2 <- matrix(rnorm(size^2), nrow=size, ncol=size)
mymatrix2.inverse <- solve(mymatrix2)
#
# now solve the matrix via the cache-method
#
special.matrix   <- makeCacheMatrix(mymatrix)
#
# this should take long, since it's the first go
start1 <- Sys.time ()
special.solved.1 <- cacheSolve(special.matrix)
end1 = Sys.time () - start1
#
# this should be lightning fast
start2 <- Sys.time ()
special.solved.2 <- cacheSolve(special.matrix)
end2 = Sys.time () - start2
#
# check if all solved matrices are identical
print(identical(mymatrix.inverse, special.solved.1) & identical(mymatrix.inverse, special.solved.2))
#
# should return TRUE
#
# Display the execution times for each approach:
print(end1)
print(end2)

# Track what happens when you modify the contents of the matrix:
special.matrix$set(mymatrix2)
special.solved.3 = cacheSolve(special.matrix)
#The following should return FALSE:
print(identical(mymatrix.inverse, special.solved.3))
#But this should return TRUE:
print(identical(mymatrix2.inverse, special.solved.3))
#So should this:
special.solved.4 = cacheSolve(special.matrix)
print(identical(mymatrix2.inverse, special.solved.4))

