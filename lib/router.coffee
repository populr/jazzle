route = (pathname, imageTransformer, response) ->
  console.log "About to route a request for #{pathname}"
  if /^\/refresh/.test(pathname)
    console.log "clearCache"
    imageTransformer.clearCache(pathname, response)
  else if /^\/\d/.test(pathname)
    console.log "transform"
    imageTransformer.transform(pathname, response)
  else
    response.writeHead 404
    response.end()

exports.route = route