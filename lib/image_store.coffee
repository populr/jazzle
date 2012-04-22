fs = require 'fs'
sunny = require 'sunny'
async = require 'async'

class ImageStore
	store: null
	bucketName: null

	constructor: (config, bucketName) ->
		@bucketName = bucketName
		sunnyCfg = sunny.Configuration.fromObj config
		@store = sunnyCfg.connection

	storeImage: (localPath, s3Path, success, error) ->
		container = null
		async.series [
			(callback) =>
				request = @store.getContainer @bucketName
				request.on 'error', error
				request.on 'end', (results, metadata) ->
					container = results.container
					callback null
				request.end()
		, 
			(callback) =>
				request = container.putBlobFromFile localPath, s3Path
				request.on 'error', error
				request.on 'end', (results, metadata) ->
					callback null
				request.end()
			],
			(err) ->
				if err?
					error err
				else
					success()

	getImage: (s3Path, localPath, success, error) ->	
		container = null
		async.series [
			(callback) =>
				request = @store.getContainer @bucketName
				request.on 'error', error
				request.on 'end', (results, metadata) ->
					container = results.container
					callback null
				request.end()
		, 
			(callback) ->
				request = container.getBlobToFile s3Path, localPath
				request.on 'error', error
				request.on 'end', (results, metadata) ->
					callback null
				request.end()
			],
			(err) ->
				if err?
					error err
				else
					success()

exports.ImageStore = ImageStore
