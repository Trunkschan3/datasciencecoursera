## Create 2 functions that create an object that can
## cache its inverse and compute the inverse of that matrix
## like object. If inverse has been calculated before (and matrix is the same)
## the function will return the inverse from the cache. 


makeCacheMatrix <- function(x = matrix()) {
  
  # Set functions set matrix and inverse
  # get functions get matrix and inverse
  
      inverse = NULL
      set = function(z){
      x <<- z
      inverse <<- NULL
      # allows us to call object from different environment
    }
    setinverse = function(matinverse) inverse<<- matinverse
    get = function()x
    getinverse = function()inverse
    list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}


## Use x (output of makeCacheMatrix()) to return inverse of original matrix

cacheSolve <- function(x, ...) {
  
  inverse = x$getinverse()
  
  if (!is.null(inverse)){
    message("getting cache data")
    return(inverse)
    # has the inverse already been calculated? If so, get from cache and print
  }
  
  matrix = x$get()
  inverse = solve(matrix, ...)
  # if not, find inverse using "solve" function. (Finds solutions to Ax = B) 
  # set value using setinverse function
  
  x$setinverse(inverse)
  
  return(inverse)
  ## Return a matrix that is the inverse of 'x'
}
