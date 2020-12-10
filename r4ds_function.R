

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






