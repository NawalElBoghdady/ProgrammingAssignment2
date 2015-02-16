## Compute the inverse of a matrix in a cached fashion. If the inverse has been computed previously,
## retrieve its value from the cache. Otherwise, compute it and store it in the cache to be used
## later.
#################################################################################################

## MatrixObj = makeCacheMatrix(x = matrix())
##
## Function makeCacheMatrix takes in a matrix 'x' and returns a list MatrixObj (which can be 
## thought of as an Object) that contains the following elements:
##      MatrixObj$set     ==> function definition that sets the value of the new matrix.
##      MatrixObj$get     ==> function definition that retrieves the value of the matrix.
##      MatrixObj$setinv  ==> function definition that stores the matrix inverse in cache.
##      MatrixObj$getinv  ==> function definition that retrieves the matrix inverse from cache.
##=======================

makeCacheMatrix <- function(x = matrix()) 
{
        ## Initialize the cache value to NULL:
        inv <- NULL
        
        ## Define the 'set' function to store the matrix value whenever it changes
        ## and reset the value of the inverse in cache:
        set <- function(y) 
        {
                ##Store new matrix value 
                x <<- y
                
                ##Reset cache
                inv <<- NULL
                
                ##You could consider these variables to be private (in C++ terms), and hence their 
                ##values can only be retrieved/modified using the 'get' and 'set' functions
        }
        
        ## Define the 'get' function to retrieve the value of the matrix:
        get <- function() x
        
        ## Define the 'setinv' function that caches the new inverse:
        setinv <- function(inverse) inv <<- inverse
        
        ## Define the 'getinv' function that retrieves the cached inverse:
        getinv <- function() inv
        
        ## Return a list with the function definitions:
        list(set = set, get = get,
             setinv = setinv,
             getinv = getinv)

}
##========================================================


## MatrixInv = cacheSolve(x = list())
##
## Function cacheSolve takes in a "special" matrix 'x' (as constructed using the previous function) 
## and returns the inverse of this matrix in MatrixInv. If the inverse of matrix 'x' has already
## been computed previously, the cached value will be returned. Otherwise, if the values of matrix
## 'x' have been modified, the new inverse is computed.
##=======================

cacheSolve <- function(x, ...) 
{
        ## Get the cached value of the inverse:
        inv <- x$getinv()
        
        # If the inverse has been computed previously, retrieve it:
        if(!is.null(inv)) {
                message("getting cached data")
        }
        else
        {
                # Otherwise, get the modified value of the matrix:
                data <- x$get()
                
                # And then compute the new inverse:
                inv <- solve(data, ...)
                
                # Store the new value of the inverse matrix in cache:
                x$setinv(inv)
        }
        
        
        # Return the inverse value
        inv
}
