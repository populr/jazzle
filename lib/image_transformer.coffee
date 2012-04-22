class ImageTransformer

  constructor: (imageStore, redis) ->
    @imageStore = imageStore
    @redis = redis

  clearCache: (requestPath, response) ->
    @_clearCache requestPath, () ->
      response.writeHead 200
      response.end()

  transform: (requestPath, response) ->
    @_transform requestPath, (renderedImageUrl) ->
      response.writeHead 302,
        'Location': renderedImageUrl
      response.end()

  _clearCache: (requestPath, finish) ->
    console.log '_clearCache'
    [bucket, key] = @imageStoreLocation(requestPath)
    console.log "bucket: #{bucket}, key: #{key}"
    finish()

  _transform: (requestPath, finish) ->
    console.log '_transform'
    [bucket, key] = @imageStoreLocation(requestPath)
    console.log "bucket: #{bucket}, key: #{key}"
    imageStoreUrl = "//s3.amazonaws.com/#{bucket}/#{requestPath}"
    tempDownloadName = "./tmp/#{_getUniqueId()}.jpg"
    async.series [
      (next) =>
        @imageStore.getImage bucket, key, tempDownloadName, ->
          next null
        , ->
          #check cache
      , (next) =>
        options = @_calcSize tempDownloadName, requestPath
        @_resize tempDownloadName, options, ->
          next null
        , ->
    ]
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
    regexp = /https?:\/\/(?:s3.amazonaws.com\/)?([^\/]*)\/(.*)$/
    matches = request.match(regexp)
    [matches[1], matches[2]]

  _calcSize: (tempDownload, requestPath) ->

  _resize: (fileToResize, options) ->


  _getUniqueId: ->
    S4 = ->
      (((1+Math.random())*0x10000)|0).toString(16).substring(1)
    new Date().getUTCMilliseconds()+S4()

exports.ImageTransformer = ImageTransformer
