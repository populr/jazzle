// Generated by CoffeeScript 1.3.1
(function() {
  var ImageTransformer;

  ImageTransformer = (function() {

    ImageTransformer.name = 'ImageTransformer';

    function ImageTransformer(imageStore, redis) {
      this.imageStore = imageStore;
      this.redis = redis;
    }

    ImageTransformer.prototype.clearCache = function(pathToImage, response) {
      return this._clearCache(pathToImage, function() {
        response.writeHead(200);
        return response.end();
      });
    };

    ImageTransformer.prototype.transform = function(pathToImage, response) {
      return this._transform(pathToImage, function(renderedImageUrl) {
        response.writeHead(302, {
          'Location': renderedImageUrl
        });
        return response.end();
      });
    };

    ImageTransformer.prototype._clearCache = function(pathToImage, finish) {
      var bucket, key, _ref;
      console.log('_clearCache');
      _ref = this.imageStoreLocation(pathToImage), bucket = _ref[0], key = _ref[1];
      console.log("bucket: " + bucket + ", key: " + key);
      return finish();
    };

    ImageTransformer.prototype._transform = function(pathToImage, finish) {
      var bucket, imageStoreUrl, key, _ref,
        _this = this;
      console.log('_transform');
      _ref = this.imageStoreLocation(pathToImage), bucket = _ref[0], key = _ref[1];
      console.log("bucket: " + bucket + ", key: " + key);
      imageStoreUrl = "//imageStore.amazonaws.com/" + pathToImage;
      return this.imageStore.getImage(bucket, key, './tmp/wegotit.jpg', function() {
        return _this.imageStore.storeImage('./tmp/wegotit.jpg', bucket, 'node_transformer.jpg', function() {
          console.log('success!!!!');
          return finish(imageStoreUrl);
        }, function(error) {
          console.log(error);
          return finish('');
        });
      }, function() {
        return finish('');
      });
    };

    ImageTransformer.prototype.imageStoreLocation = function(request) {
      var matches, regexp;
      console.log("imageStoreLocation: " + request);
      regexp = /https?:\/\/(?:imageStore.amazonaws.com\/)?([^\/]*)\/(.*)$/;
      matches = request.match(regexp);
      return [matches[1], matches[2]];
    };

    return ImageTransformer;

  })();

  exports.ImageTransformer = ImageTransformer;

}).call(this);
