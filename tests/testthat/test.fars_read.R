parent.dir <- getwd()
test.dir <- system.file("extdata", package = "FARSinR2")

setwd(test.dir)

test_that('fars_read function read files in the working directory', {

  expect_equal(ncol(fars_read("accident_2013.csv.bz2")), 50)
  expect_equal(nrow(fars_read("accident_2014.csv.bz2")), 30056)

})

setwd(parent.dir)
