http = require 'http'
url = require 'url'

start = (route, imageTransformer) ->
  onRequest = (request, response) ->
    pathname = url.parse(request.url).pathname

    route(pathname, imageTransformer, response)

  http.createServer(onRequest).listen(8888)
  console.log 'image transformer has started'

exports.start = start
