#' Invoke a Lambda function
#'
#' @param name name of the lambda function
#' @param payload a toJSON-able R object
#' @param ... not used
#' @param context the client context
#' @param client a Lambda client (invoke will be called upon it)
#' @return function result
#' @importFrom jsonlite toJSON fromJSON base64_enc
#' @export
#' @examples
#' \dontrun{
#' # Using the default hello-world lambda function, default event, and default auth:
#' AWR.Lambda::invoke("myFunctionName",  list(key3="value3", key2="value2",key1="value1"))
#' }

invoke <- function(name, payload, ..., context, client=lambda_client()) {
  request <- .jnew('com.amazonaws.services.lambda.model.InvokeRequest')
  request$setFunctionName(name)
  if(!missing(context)) request$setClientContext(base64_enc(toJSON(context)))
  request$setPayload(unclass(toJSON(payload)))

  result <- client$invoke(request)
  decode_payload(result)
}

decode_payload <- function(result) {
  pl <- result$getPayload()$asReadOnlyBuffer()

  charset <- J("java.nio.charset.StandardCharsets")
  x <- charset$UTF_8$decode(pl)

  fromJSON(x$toString())


}

#' @export
#' @rdname invoke
lambda_client <- function() {
  client <- .jnew('com.amazonaws.services.lambda.AWSLambdaClientBuilder')$defaultClient()

  ## fail on error
  if (inherits(client, 'SdkClientException')) {
    stop(paste(
      'There was an error while starting the Lambda Client, probably due to no configured AWS Region',
      '(that you could fix eg in ~/.aws/config or via environment variables, then reload the package):',
      client$message))
  }

  ## return
  invisible(client)
}
