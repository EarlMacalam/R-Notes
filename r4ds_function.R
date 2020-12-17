

# Exercise 1 --------------------------------------------------------------

## 1
rescale01 <- function(x) {
        rng <- range(x, na.rm = F) 
        (x - rng[1]) / (rng[2] - rng[1])
}
rescale01(c(0, 5, 10)) 

# If x contains a single missing value and na.rm = FALSE, then this function 
# stills return a non-missing value.

## 2
x <- c(1:10, Inf)
rescale01 <- function(x) {
        rng <- range(x, na.rm = TRUE, finite = TRUE) 
        (x - rng[1]) / (rng[2] - rng[1])
}
rescale01(x)

rescale02 <- function(x) {
        rng <- range(x, na.rm = T, finite = T) 
        val <- (x - rng[1]) / (rng[2] - rng[1])
        val[val == -Inf] <- 0
        val[val == Inf] <- 1
        val
}
rescale02(c(Inf, -Inf, 0:5, NA))


## 3
# mean(is.na(x))
prop_na <- function(x) {
        mean(is.na(x))
}
prop_na(c(0, 1, 2, NA, 4, NA))

# x / sum(x, na.rm = TRUE)
standardize <- function(x) {
        x / sum(x, na.rm = T)
}

standardize(c(0, 1, 2, NA, 4, NA))

# sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)
coef_variation <- function(x) {
        sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)
}

coef_variation(1:5)

## 4
variance <- function(x) {
        n <- length(x)
        m <- mean(x, na.rm = T)
        sq_err <- (x - m)^2
        var <- sum(sq_err) / (n - 1)
        var
}
variance(1:10)
var(1:10)

skewness <- function(x) {
        n <- length(x)
        m <- mean(x)
        sq_err <- (x - m)^2
        var <- sum(sq_err) / (n - 1)
        
        cb_err <- (x - m)^3
        numerator <- sum(cb_err) / (n - 2)
        skew <- numerator / (var)^(3/2)
        skew
}

skewness(c(1, 2, 5, 100))

## 5
both_na <- function(x, y) {
        sum(is.na(x) & is.na(y))
}

both_na(x <- c(NA, 2, NA),
        y <- c(NA, 7, NA))


# Exercise 2 --------------------------------------------------------------

## 1 
f1 <- function(string, prefix) { 
        substr(string, 1, nchar(prefix)) == prefix
}
f1(c("abc", "abcde", "ad"), "ab")
# better name: has_prefix

f2 <- function(x) {
        if (length(x) <= 1) return(NULL)
        x[-length(x)] 
}
f2(c(1, 2, 3, 4, 5, 6, 7, 8, 9))
# better name: drop_last

f3 <- function(x, y) {
        rep(y, length.out = length(x))
}

x <- c(1, 2, 3, 4, 5, 6, 7)
y <- c(4, 5)
f3(x, y)
# better name: recycle()


# Exercise 3 --------------------------------------------------------------

## 1

# if() function only deals with single element, thats why if we will use this
# function to vectorize form, 'it would produce error the condition has 
# length > 1 and only the first element will be used'. On other hand, ifelse()
# is designed for vectorize form conditioning. 

## 2
library(lubridate)

greet <- function(time) {
        hr <- hour(now())
        
        if (hr >= 1 && hr < 12) {
                print("Good Morning")
        } else if (hr >= 12 && hr < 18) {
                print("Good Afternoon")
        } else {
                print("Good Evening")
        }
}

## 3

fizzbuzz <- function(number) {
        if (number %% 3 == 0 && number %% 5 == 0) {
                print("fizzbuzz")
        } else if (number %% 3 == 0) {
                print("fizz") 
        } else if (number %% 5 == 0) {
                print("buzz")
        } else {
                as.character(number)
        }
}

fizzbuzz(15)
fizzbuzz(3)
fizzbuzz(2)

## 4

temp <- seq(-10, 50, by = 5)
# Equality included
cut(temp, c(-Inf, 0, 10, 20, 30, Inf),
    right = TRUE,
    labels = c("freezing", "cold", "cool", "warm", "hot")
)
# Equality not included
cut(temp, c(-Inf, 0, 10, 20, 30, Inf),
    right = FALSE,
    labels = c("freezing", "cold", "cool", "warm", "hot")
)

# cut() works on vectors while simple if() not.

## 5

# The first argument of switch (which should be a whole number) returns the nth
# position in the remaining arguments. Using numeric value for the first
# position argument would only just truncate the non integer part of it instead
# of rounding up or down. As an example:
switch(1.2, "apple", "banana", "okra")
switch(2.5, "apple", "banana", "okra")

## 6

switch("a", a=, b = "ab", c=, d="cd")
switch("c", a=, b = "ab", c=, d="cd", z = "cd")
switch("z", a=, b = "ab", c=, d="cd", "la")

# For missing values, it will get the succeeding nonmissing value. If the first
# argument has no match, then it will get unamed argument. IF there are same
# arguments, it will just get the first match.


# Exercise 4 --------------------------------------------------------------
library(tidyverse)
df <- tibble(
        a = rnorm(10), b = rnorm(10), c = rnorm(10), d = rnorm(10)
)
df
output <- vector("double", ncol(df))



# For loops ---------------------------------------------------------------


# Exercise 1 --------------------------------------------------------------

## 1 
output <- vector("double", ncol(mtcars))
for (i in seq_along(mtcars)) {
        output[[i]] <- mean(mtcars[[i]])
}
output

type <- vector("list", ncol(flights))
for (i in seq_along(flights)) {
        type[[i]] <- class(flights[[i]])
}
type 

unique <- vector("double", ncol(iris))
for (i in seq_along(iris)) {
        unique[[i]] <- n_distinct(iris[[i]])
}
unique

# another way
iris_uniq <- vector("double", ncol(iris))
names(iris_uniq) <- names(iris)
for (i in names(iris)) {
        iris_uniq[[i]] <- n_distinct(iris[[i]])
}
iris_uniq

n <- 10
mu <- c(-10, 0, 10, 100)
normals <- vector("list", length(mu))
names(normals) <- c("mean = -10", "mean = 0", "mean = 10", "mean = 100")

for (i in seq_along(mu)) {
        normals[[i]] <- rnorm(n, mu[[i]])
}
normals

## 2
out <- ""
for (x in letters) {
        out <- stringr::str_c(out, x) 
}
out

str_c(letters, collapse = "")

x <- sample(100)
sd <- 0
for (i in seq_along(x)) {
        sd <- sd + (x[i] - mean(x))^2 
}
sd <- sqrt(sd / (length(x) - 1))

sd(x)

x <- runif(100)
out <- vector("numeric", length(x)) 
out[1] <- x[1]
for (i in 2:length(x)) {
        out[i] <- out[i - 1] + x[i] 
}
out

cumsum(x)

## 3

humps <- c("five", "four", "three", "two", "one", "no")

for (i in humps) {
        cat(str_c("Alice the camel has ", rep(i, 3), " humps.",
                  collapse = "\n"), "\n")
        
        if (i == "no") {
                cat("Now Alice is a horse.\n")
        } else {
                cat("So go, Alice, go.\n")
        }
        cat("\n")
}


number <- c("ten", "nine", "eight", "seven", "six", "five", "four", "three", 
            "two", "one")

for (i in number) {
        cat("There were ", rep(i, 1),
            " in the bed\n")
        
        if (i == "one") {
                cat("and the little one said,\n“I’m lonely…”\n")
        } else {
                cat("and the little one said,\n“Roll over, roll over.”\nSo they all rolled over and one fell out.\n")
        }
        cat("\n")
}

beer_bottles <- function(n) {
        
        for (i in n:1) {
                cat(i,"bottles of beer on the wall ", i," bottles of beer.\n")
                
                if (i == 1){
                        cat("Take one down, pass it around no more bottles of beer on the wall\n\nNo more bottles of beer on the wall, no more bottles of beer.\nWe’ve taken them down and passed them around; now we’re drunk and passed out!\n")
                } else {
                        cat("Take one down, pass it around ", i-1, " bottles of beer on the wall\n")
                }
                cat("\n")
        }

}

beer_bottles(99)

# Exercise 2 --------------------------------------------------------------


