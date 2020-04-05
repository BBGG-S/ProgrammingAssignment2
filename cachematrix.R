## The aim of this assignment is to write two functions that cache the inverse of a matrix using Lexical Scope concepts.
## The two functions created are: makeCacheMatrix and cacheSolve


## makeCacheMatrix function creates a special "matrix" object that can cache its inverse or store the matrix and its inverse


 
makeCacheMatrix <- function(x = matrix()) { 

## first initialize the two objects x and n1, where x is the argument to be passed when testing in makeCacheMatrix for the matrix 
## and n1 will be used later in the function for the matrix inverse

n1<-NULL

## set() takes as an argument an object, that is supposed to be a matrix, named m1 

set<-function(m1){

## with the <<- operator we assign a value to an object in an environment that is different from the current environment.
## When set executes, the following row assigns the input argument to the x object in the parent environment,

x<<- m1

## and the folliwing row assigns a value of NULL to the n1 object in the parent environment, in order to erase 
## any value of n1 that had been cached by a prior execution of cacheSolve()

n1<<- NULL
}

## th following row gets the matrix x

get<-function() x

## the following row sets for the inverse n1

setinverse<-function(solve) n1<<-solve

## the following row gets the inverse n1

getinverse<-function()n1

## Now we create a new object by returning a list() to assign each of these functions as an element within a list () and return it to the parent environment. 
## Here we're naming the list elements, so we can use the $ form of the extract operator to access the functions by name rather than by [[

list(set=set, get=get, setinverse = setinverse, getinverse = getinverse)
 
} 

 

 

## cacheSolve requires an argument that is returned by makeCacheMatrix() in order to retrieve the inverse from the cached value that is stored in the makeCacheMatrix() object's environment. 
## cacheSolve computes the inverse of the special "matrix" returned by makeCacheMatrix above.
## If the inverse has already been calculated (and the matrix has not changed), then the cachesolve should retrieve the inverse from the cache.


 
cacheSolve <- function(x, ...) {

## Return a matrix that is the inverse of 'x'

## the function tries to retrieve an inverse from the matrix object passed in as the argument. 
## First, it calls the getinverse() function on the input object

n1<-x$getinverse()

## then it checks to see whether the result is NULL. 
## Since makeCacheMatrix() sets the cached inverse to NULL whenever a new matrix is set into object, 
## if the value here is not equal to NULL, we have a valid, cached inverse and can return it to the parent environment

if (!is.null(n1)) {
message("getting cached data")
return (n1)
}

## on the other side, if the result of !is.null(n1) is FALSE, cacheSolve() gets the matrix from the input object, calculates the solve(), 
## uses the setinverse() function on the input object to set the inverse in the input object, 
## and then returns the value of the inverse to the parent environment by printing the inverse object

data<-x$get()
n1<-solve(data)
x$setinverse(n1)
n1

## for example, if we create an example_matrix as follows
## example_matrix <- matrix(c(1/2, -1/4, -1, 3/4), nrow = 2, ncol = 2) 
## and then we set 
## myMatrix_object <- makeCacheMatrix(example_matrix)
## the first time we run
## cacheSolve(myMatrix_object)
## we obtain the inverse of example_matrix
##     [,1] [,2]
##[1,]    6    8
##[2,]    2    4
## the second time we run 
## cacheSolve(myMatrix_object)
## we obtain, obviously, the same inverse matrix but before the matrix we have the message "getting cached data"


} 
