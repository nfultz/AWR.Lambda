# AWS.Lambda

This an R client to interact with the [AWS Lambda Service](https://aws.amazon.com/lambda), including wrapper functions around the [Lambda Java client](http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/Lambda/AWSLambdaClient.html) to invoke functions on that service.

## Installation

![CRAN version](http://www.r-pkg.org/badges/version-ago/AWR.Lambda)

You can  easily install the most recent development version of the R package:

```r
remotes::install_github('nfultz/AWR.Lambda')
```

This R package relies on the `jar` files bundled with the [AWR package](https://cran.r-project.org/package=AWR).

## What is it good for?

Currently, only the most important features are supported:

* you can invoke a lambda function:

```r
> AWR.Lambda::invoke("myFunctionName",  list(key3="value3", key2="value2",key1="value1"))
[1] "Hello from Lambda"
```


## What if I want to do other cool things with Lambda and R?

Writing wrapper functions around the Java SDK is very easy. Please open a ticket on the feature request, or even better, submit a pull request :)

## It doesn't work here!

To be able to use this package, you need to have an [AWS account](https://aws.amazon.com/free).
If you do not have one already, you can register for free at Amazon, although you may be billed for using lambda functions .

Once you have an AWS account, make sure your default AWS Credentials are available via the [DefaultAWSCredentialsProviderChain ](http://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/credentials.html). In short, you either provide a default credential profiles file at `~/.aws/credentials`, use the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables or if using `AWR.Lambda` on AWS, you can also rely on the EC2 instance profile credentials or ECS Task Role as well.
