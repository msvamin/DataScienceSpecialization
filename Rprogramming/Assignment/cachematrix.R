## Computing the inverse of a square matrix. 
## If the inverse exists it used at as a cached data, and it doesn't re-calculate it.
## The first function sets the value for the matrix, and the second function calculates the inverse.

## This function sets and gets the value for the matrix and its inverse

makeCacheMatrix <- function(x = matrix()) {
  InvM <- NULL
  # Set the value for the matrix
  set <- function(y) {
    x <<- y
    InvM <<- NULL
  }
  # Get the value for the matrix
  get <- function() x
  # Set the value for the inverse
  setInv <- function(inv) InvM <<- inv
  # Get the value for the inverse
  getInv <- function() InvM
  list(set=set, get=get, setInv=setInv, getInv=getInv)
}


## This function check for the existense of inverse.
## If the inverse exists it returns its value, otherwise it calculates the inverse.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  InvM <- x$getInv()
  # If the inverse exists it returns it
  if(!is.null(InvM)) {
    message("getting cached data")
    return(InvM)
  }
  # The inverse doesn't exist and it calculates and returns it
  data <- x$get()
  InvM <- solve(data, ...)
  x$setInv(InvM)
  InvM
}
