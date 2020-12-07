
# R Programming Fundamentals

This notes were based from Data Science by John Hopkins Universrity online course in coursera.

## Installing Packages
```{r}
install.packages("name.of.package")
install.packages(c("pck1", "pck2", "pck3"))
```

## Loading Packages

```{r}
library(name.of.package) #do not use qoutes in package name when using library
search() #to know what are the functions contained in the package embedded in library
```

## Some Important Functions
```{r}
#Access help files
?rnorm

#Search help files
help.search("rnorm")

#Get arguments
args("rnorm")
```


## Vectors, List, Matrices, etc.
```{r}
x <- 1:20 ##creates sequence of numbers

# c means concatinate
x <- c(0.5, 0.6) ##numeric vector
x <- c(TRUE, FALSE) ##logical vector
x <- c(T, F) ##logical vector shrtct
x <- c("a", "b", "c") ##character vector
x <- 9:29 #integer
x <- c(1+0i, 2+4i) ##complex vector

#vector() function
x <- vector("numeric", length = 10) ##by default the numeric value is 0

#Coercion (Mixing objects)
y <- c(1.7, "a") ##character
y <- c(TRUE, 2) ##numeric
y <- c("a", TRUE) ##character

#Converting using the as. function
x <- 0:6
class(x)
as.numeric(x) ##converting to numeric
as.logical(x) ##converting to logical
              ## 0 is false and anything greather than 0 is true
as.character(x) ##converting to 

#List
x <- list(1, "a", TRUE, 1 + 4i)

#Matrices
m <- matrix(nrow = 2, ncol = 3)
m
dim(m) ##gives the no. of row and column
attributes(m) ##same to dim

#Matrices are constructed column-wise
m <- matrix(1:6, nrow = 2, ncol = 3)
m

#Creating matrices by dimension attribute
m <- 1:10
m
dim(m) <- c(2, 5)
m

#Creating matrix using column binding and row binding
x <- 1:3
y <- 10:12
x
y
#column binding
cbind(x, y)
#row binding
rbind(x, y)

#Factors
x <- factor(c("yes", "yes", "no", "yes", "no"))
x
table(x) ##tells number of no and yes
unclass(x) #how element represented in R

#Ordering the levels in factor
x <- factor(c("yes", "yes", "no", "yes", "no"),
              levels = c("yes", "no")) ##by default, ordering is based alphabetically

#Missing values
is.na() ##test objects if they are NA/missing
is.nan() ##test objects if they are undefined
#Examples
x <- c(1, 2, NA, 10, 3)
is.na(x)
is.nan(x)
x <- c(1, 2, NaN, NA, 4)
is.na(x) ##both true for NaN and NA
is.nan(x) ##only true for NaN

#DataFrames
x <- data.frame(foo = 1:4, bar = c(T, T, F, F)) ##foo 1st colm, bar 2nd colm
x
nrow(x)
ncol(x)

#Names
x <- 1:3
names(x)
names(x) <- c("foo", "bar", "norf") #this gives name to the elements in vector
x
names(x)
#list can also have names
x <- list(a = 1, b = 2, c = 3)
x
#matrices can also have names
m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d"))
                ##1st vector names of 2d row
                ##2nd vector names of 2d column
m

#a quick way to figure out the classes of each column
initial <- read.table("datatable.txt", nrow = 100)
classes <- sapply(initial, class)
tabAll <- read.table("datatable.txt",
                     colClasses = classes)

#dput-ting R objects (isahang pag recall)
y <- data.frame(a = 1, b = "a")
dput(y)
dput(y, file = "y.R")
new.y <- dget("y.R")
new.y
#dumping R objects (maramihan)
x <- "foo"
y <- data.frame(a = 1, b = "a")
dump(c("x","y"), file = "data.R")
rm(x,y)
source("data.R")
y
x

#Subsetting 
#Subsetting Vector
x <- c("a", "b", "c", "c", "d", "a")
x[1] ##numeric index
x[2]
x[1:3]
x[1:4]
x[x > "a"] ## logical index, all x > a           
u <- x > "a"
u
x[u] ##subsetting

#Subsetting Lists
x <- list(foo = 1:4, bar = 0.6)
x[1]
x[[1]]
x$bar
x[["bar"]]
x[2]
x[[2]]
x["bar"]
#multiple element list
x <- list(foo = 1:4, bar= 0.4, baz = "hello")
x[c(1, 3)]
# double bracket and dollar difference
x <- list(foo = 1:4, bar= 0.4, baz = "hello")
name <- "foo"
x[[name]] #exist
x$name #doesnt exist
x$foo #exist
#nested list subsetting
x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
x
x[[c(1, 3)]] ##1st elemnt of list and 3rd elemnt of that list
x[[c(2, 1)]] ##2nd element list and 1st element of that list

#Subsetting Matrices
x <- matrix(1:6, 2, 3)
x[1, 2] ##1st index = 1st row
        ##2nd index = 2nd column
        ##1st row 2nd column element
x[2, 1]
#indeces can also be missing
x[1, ] #means i want the 1st row of the matrix
x[ ,2] #means i want the second column of the matrix
#about the type of object
x <- matrix(1:6, 2, 3)
x[1, 2] ##returns vector object instead of matrix
#remedy
x[1, 2, drop = FALSE] #when we want to preserve the original structure
                      #by default is TRUE
#when just row
x <- matrix(1:6, 2, 3)
x[1, , drop = FALSE]
#when just column
x <- matrix(1:6, 2, 3)
x[ , 2, drop = FALSE]

#Partial Matching
x <- list(aardvark = 1:5)
x$a ##match a to aardvark
x[["a"]] ##invalid
x[["a", exact = FALSE]] ##remedy

#Removing NA/MISSING values
x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x) #just a vector which tells true if missing and false if not
x[!bad] #opposite of is.na() which produce nonmissing
        # !-opposite operator
#subsetting multiple things with no missing values
x <- c(1, 2, NA, 4, NA, 5)
y <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(x, y) ##checks the vector. true if not missing and false if missing
good
x[good]
y[good]
#dataframe example code, removing rows with missing values
airquality[1:6, ]
good <- complete.cases(airquality)
airquality[good, ][1:6, ]

#Vectorized Operations
x <- 1:4; y <- 6:9
x+y ##add element one by one
x > 2 ##compare elements to x
x >= 2
y == 8 ##compare elements to y
x * y ##multiplication
x / y ##division

#Vectorized Matrix Operations
x <- matrix(1:4, 2, 2); y <- matrix(rep(10, 4), 2, 2)
x
y
x * y ##element-wise multiplication
x / y ##element-wise division
x %*% y ##true matrix multiplication
```

# Control Structures


# Introduction

Control structures in R allow you to control the flow of execution of the program , depending on runtime conditions. Common structures are

* **if, else**: testing condition

* **for**: execute a loop a fixed number of times

* **while**: execute a loop while a condition is true

* **repeat**: execute an infinite loop

* **break**: break the execution of a loop

* **next**: skip an iteration of a loop

* **skip**: exit a function

# Control Structures: if

The syntax:
```{r}
x <- c(1, 2, 3, 4, 5, 6)
if(x > 3) {
  y <- 10
} else {
  y <- 0
}
```
An alternative way would be:
```{r}
x <- c(1, 2, 3, 4, 5, 6)
y <- if(x > 3) {
  10
} else {
  0
}
```

# Control Structures: for

**for loops** take an iterator variable and assign it successive values from a sequence or vector. For loops are most commonly used for iterating over the elements of an object (list, vector, etc.)
```{r}
for (i in 1:10){
  print(i)
}
```
These four loops have the same behavior
```{r}
x <- c("a", "b", "c", "d")

for (i in 1:4){
  print(x[i])
}

for (i in seq_along(x)){
  print(x[i])
}

for (letter in x){
  print(letter)
}

for (i in 1:length(x)){
  print(x[i])
}
```
Let's try **Nested for loops**
```{r}
x <- matrix(1:6, 2, 3)

for(i in seq_len(nrow(x))){
  for(j in seq_len(ncol(x))){
    print(x[i, j])
  }
}
```
An alternate code would be:
```{r}
x <- matrix(1:6, 2, 3)

for(i in 1:nrow(x)){
  for(j in 1:ncol(x)){
    print(x[i, j])
  }
}
```
*Note to self: Finish first the full iteration of the inner loop then after that return to outer loop. The loop ends base on the iteration of the outer loop.*

# Control Structures: while

**while loops** begin by testing a condition. If it is true, then they execute the loop body. Once the loop body is executed, the condition is tested again, and so forth.
```{r}
count <- 0
while(count < 10) {
  print(count)
  count <- count + 1
}
```
Sometimes there will be more than one condition in the test.
```{r}
z <- 5

while(z >= 3 && z <= 10) {
  print(z)
  coin <- rbinom(1, 1, 0.5) 
  
  if(coin == 1) {
    z <- z + 1
  } else {
    z <- z - 1
  }
}
```
Conditions are always evaluated from left to right (e.g in our example first it checks if z >= 3 then if its true then check if z <= 3 then if its true proceed to the loop and so on ...)

# Control Structures: repeat

**Repeat** initiates an infinite loop; these are not commonly used in statistical applications but they do have their uses. The only way to exit a repeat loop is to call **break**
```{r}
x0 <- 1
to1 <- 1e-8

repeat {
  x1 <- 0##computeEstimate()
  
  if(abs(x1 - x0) < to1){
    break
  } else {
    x0 <- x1
  }
}
```

# Control Structures: next
 **next** is used skip an iteration of a loop
```{r}
for(i 1:100) {
  if(i <= 20) {
    ## Skip the first 20 iterations
    next
  }
  ## Do something here
}
```
*Note to self: **next** is a way to skip an iteration in the loop while **break** is a way to exit the loop entirely (and execute again).*

# Control Structures: return

**return** signals that a function should exit and return a given value.

# Function

My first R function
```{r}
add2 <- function(x, y) {
  x + y
}
add2(3, 5)
```
Slightly challenging example
```{r}
above <- function(x, n) {
  use <- x > n
  x[use]
}

x <- 1:20
above(x, 12)
```
We can specify the default value n, say n = 10.
```{r}
above <- function(x, n = 10) {
  use <- x > n
  x[use]
}

x <- 1:20
above(x)
```
for loop within function example
```{r}
columnmean <- function(y) {
  nc <- ncol(y)
  means <- numeric(nc) ##initialize a vector that will store the means for each column
                       ##The length of this vector should be equal to the number of 
                       ##columns, initially this is an empty vector with elements all 
                       ##equal to 0 and we're gonna fill it as we go building our  
                       ##function so lets do for loops to fill this empty vector
  for(i in 1:nc) {
    means[i] <- mean(y[ , i])
  }
  return(means)
}
columnmean(airquality)
```
What if we want to remove NA values ? With slight modification in our code we have
```{r}
columnmean <- function(y, removeNA = TRUE) {
  nc <- ncol(y)
  means <- numeric(nc)
  for(i in 1:nc) {
    means[i] <- mean(y[ , i], na.rm = removeNA)
  }
  return(means)
}
columnmean(airquality)
columnmean(airquality, FALSE) ##NA's comeback by this code
```

# Functions

Functions are created using function() directive and are stored as R objects just like anything else, they are R objects of class "function".
```{r}
f <- function(<arguments>) {
  ## Do something interesting
}
```
* Functions can be passed as arguments to other functions

* Functions  can be nested, so that you can define function within function.

* The return value of a function is the last expression in the function body to be evaluated.

R arguments can be matched positionally or by name. So the following calls to sd are equivalent
```{r}
mydata <- rnorm(100)
sd(mydata)
sd(x = mydata)
sd(x = mydata, na.rm = FALSE)
sd(na.rm = FALSE, x = mydata)
sd(na.rm = FALSE, mydata)
```
Even though it's legal, it is not recommended messing around with the order of the arguments too much since it can lead to some confusion.

* Most of the time, named arguments are useful on the command line when you have a long argument list and you want to use the defaults for everything except for an argument near the end of the list.

* Name arguments also help when you can remember the name of the argument and not its position on the argument list (plotting is a good example).

# Defining a Function
```{r}
f <- function(a, b = 1, c = 2, d = NULL) {
  
}
``` 
In addition to not specifying a default value, you can also set and argument value to NULL.

# Lazy Evaluation
```{r}
f <- function(a, b){
  print(a)
  print(b)
}
f(45)
```
Notice that 45 got printed first before the error was triggered. This is because b did not have to be evaluated until after print(a). Once the function tried to evaluate print(b) it had to throw an error.

# Lexical Scoping
```{r}
make.power <- function(n) {
  pow <- function(x){
    x^n
  }
  pow
}
cube <- make.power(3)
cube(3)

square <- make.power(2)
square(2)

```

# Coding Standards for R

1. Always use text files / text editor.

2. Indent your code.

3. Limit the width of your code (80 columns?).

4. Limit the length of individual functions.

# Dates and Times in R

R has developed a special representation of dates and times.

* Dates are represented by the Date class

* Times are represented by the POSIXct or the POSIXlt class

* Dates are stored internally as the number of days since 1970-01-01

* Times are stored internally as the number of seconds since 1970-01-01

```{r}
x <- as.Date("1970-01-01")
x
unclass(x)
```
Times can be coerced from a character string using the as.POSIXlt or as.POSIXct function.
```{r}
x <- Sys.time()
x
p <- as.POSIXlt(x)
names(unclass(p))
p$mday
```
Finally, there is the strptime function in case your dates are written in a different format.
```{r}
datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x
class(x)
```

# Loop Functions

## Looping on the Command Line

Writing for, while loops is useful when programming but not particularly easy when working interactive on the command line. There are some functions which implement looping to make life easier.

* **lapply**: Loop over a list and evaluate a function on each element

* **sapply**: Same as lapply but try to simplify the result

* **apply**: Apply a function over the margins of an array

* **tapply**: Apply a function over subsets of a vector

* **mlapply**: Multivariate version of lapply

An auxillary split is also useful, particularly in conjunction with lapply.

**lapply** takes three arguments

1. a list x

2. a function (or the name of the function) FUN

3. other arguments via it ... argument

If x is not a list, it will be coerced to a list using as.list

```{r}
x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)
```
lapply always returns a list. Another example.
```{r}
x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)
```
Another example
```{r}
x <- 1:4
lapply(x, runif)
```
Slight modification example
```{r}
x <- 1:4
lapply(x, runif, min = 0, max = 10)
```
**Anonymous Functions** are functions with no names. lapply and friends make heavy use of anonymous functions.
```{r}
x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
x
lapply(x, function(getcol1) getcol1[ ,1])
```
Note that lapply always return a list. Observe what sapply does.
```{r}
x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)
sapply(x, mean)
```
sapply transformed our list values to vector which is much elegant.

# apply
```{r}
str(apply)
```
* x is an array

* MARGIN is an integer vector indicating which margins should be retained.

* FUN is a function to be applied

* ... is for other arguments to be passed to FUN
```{r}
x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean) # 2 means preserve all the columns and eliminate the rows
apply(x, 1, sum) # 1 means the opposite of 2. 
```

# col/row sums and means

For sums and means of matrix dimensions, we have shortcuts

* rowSums = apply(x, 1, sum)

* rowMeans = apply(x, 1, mean)

* colSums = apply(x, 2, sum)

* colMeans = apply(x, 2, mean)

The shortcut functions are much faster, but you won't notice unless you're using a large matrix.

Quantiles of the rows of a matrix
```{r}
x <-  matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs = c(0.25, 0.75))
```
Average matrix in an array
```{r}
a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
apply(a, c(1, 2), mean)
```

# mapply

**mapply** is a multivariate apply of sorts which applies a function in parallel over a set of arguments.
```{r}
str(mapply)
```
* FUN is a function to apply

* ... contains arguments to apply over

* MoreArgs is a list of other arguments to FUN

* SIMPLIFY indicates wether the result should be simplified

The following is tedious to type
```{r}
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
```
Instead we can do
```{r}
mapply(rep, 1:4, 4:1)
```

# Vectorizing a Function
```{r}
noise <- function(n, mean, sd) {
        rnorm(n, mean, sd)
}

noise(5,1,2)
```
What if I set n to be vector and mean to be also vector and fixed my standard deviation to  2. Here, we will use the mapply which produce output that have 1 mean, 2 mean, 3 mean, and so on and so forth ...
```{r}
mapply(noise, 1:5, 1:5, 2)
```

# tapply
**tapply** is used to apply a function over subsets of a vector.
```{r}
str(tapply)
```

* X is a vector

* INDEX is a factor or a list of factors(or else they are coerced to factors)

* FUN is a function to be applied

* ... contains other arguments to be passed FUN

* simplify, should we simplify the result?

Take group means
```{r}
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10) ## factor vrbls w/ 3lvls repeated 10x
f
tapply(x, f, mean)
```
Calculating the range
```{r}
tapply(x, f, range)
```

# split

**split** takes a vector or other objects and splits it into groups determined by a factor or list of factors.
```{r}
str(split)
```

* x is a vector (or list) or data frame

* f is a factor (or coerced to one) or a list of factors

* drop indicates wether empty factors levers should be dropped
```{r}
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10) 
split(x, f)
```

# Splitting Data Frame
```{r}
library(datasets)
head(airquality)

s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[ ,c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[ ,c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[ ,c("Ozone", "Solar.R", "Wind")], na.rm = TRUE))
```

# Splitting more than one level

```{r}
x <- rnorm(10)
f1 <- gl(2, 5)
f2 <- gl(5, 2)
f1
f2
interaction(f1, f2)

str(split(x, list(f1, f2)))
str(split(x, list(f1, f2), drop = TRUE)) ## drop empty levels that are created
```

# Debugging Tools - Diagnosing the problem

Indications that something's not right

* **message**: A generic notification/diagnostic message produced by message function; execution of the function continues

* **warning**: An indication that something is wrong but not necessarily fatal; execution of the function continues; generated by the warning function

* **error**: An indication that a fatal problem has occured; execution stops; produced by the stop function.

* **condition**: A generic concept for indicating that something unexpected can occur; programmers can create their own conditions.
```{r}
log(-1)
```
```{r}
printmessage <- function(x) {
        if(is.na(x))
                print("x is a missing value")
        else if(x > 0) 
                print("x is greater than 0")
        else
                print("x is less than 0")
}
printmessage(3)
printmessage(-3)
printmessage(0)
printmessage(NA)
x <- log(-1)
printmessage(x)
```

How do you know if something is wrong with your function?

* What was your input? How did you call the function?

* What were you expecting? Output, messages, other results?

* What did you get?

* How does what you get differ from what you were expecting?

* Were your expectations correct in the first place?

* Can you reproduce the problem (exactly)?

# Debugging Tools in R

The primary tools for debugging functions in R are

* **traceback**: prints out the function call stack after an error occurs; does nothing if there's no error.

* **debug**: flags a function for "debug" mode which allow you to step through execution of a function one line at a time

* **browser**: suspends the execution of a function wherever it is called and puts the function in debug mode

* **trace**: allows you to insert debugging code into a function a specific places

* **recover**: allows you to modify the error behavior so that you can browse the function call stack

These are interactive tools specifically designed to allow you to pick through a function. There's also the more blunt technique of inserting print/cat statements in the function.
