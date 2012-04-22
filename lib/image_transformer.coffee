class ImageTransformer
  init: (s3, redis) ->
    @s3 = s3
    @redis = redis

  clearCache: (pathToImage, response) ->
    @_clearCache pathToImage, () ->
      response.writeHead 200
      response.end()

  transform: (pathToImage, response) ->
    @_transform pathToImage, (renderedImageUrl) ->
      response.writeHead 302,
        'Location': renderedImageUrl
      response.end()

  _clearCache: (pathToImage, finish) ->
    console.log '_clearCache'
    [bucket, key] = @s3Location(pathToImage)
    console.log "bucket: #{bucket}, key: #{key}"
    finish()

  _transform: (pathToImage, finish) ->
    console.log '_transform'
    [bucket, key] = @s3Location(pathToImage)
    console.log "bucket: #{bucket}, key: #{key}"
    s3Url = ''
    finish(s3Url)


  s3Location: (request) ->
    console.log "s3Location: #{request}"
    # remove #s3.amazonaws.com/, then get the next part as the bucket, and everything after as the key
    regexp = /https?:\/\/(?:s3.amazonaws.com\/)?([^\/]*)(.*)$/
    matches = request.match(regexp)
    [matches[1], matches[2]]

exports.ImageTransformer = ImageTransformer
