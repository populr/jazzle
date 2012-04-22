class ImageTransformer

  constructor: (imageStore, redis) ->
    @imageStore = imageStore
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
    [bucket, key] = @imageStoreLocation(pathToImage)
    console.log "bucket: #{bucket}, key: #{key}"
    finish()

  _transform: (pathToImage, finish) ->
    console.log '_transform'
    [bucket, key] = @imageStoreLocation(pathToImage)
    console.log "bucket: #{bucket}, key: #{key}"
    imageStoreUrl = "//imageStore.amazonaws.com/#{pathToImage}"
    @imageStore.getImage bucket, key, './tmp/wegotit.jpg', () =>
      # success
      @imageStore.storeImage './tmp/wegotit.jpg', bucket, 'node_transformer.jpg', () ->
        console.log 'success!!!!'
        finish(imageStoreUrl)
      , (error) ->
        # error
        console.log error
        finish('')
    , () ->
      # error
      finish('')


  imageStoreLocation: (request) ->
    console.log "imageStoreLocation: #{request}"
    # remove #imageStore.amazonaws.com/, then get the next part as the bucket, and everything after as the key
    regexp = /https?:\/\/(?:imageStore.amazonaws.com\/)?([^\/]*)\/(.*)$/
    matches = request.match(regexp)
    [matches[1], matches[2]]

exports.ImageTransformer = ImageTransformer
