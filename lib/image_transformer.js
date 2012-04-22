(function() {
  var ImageTransformer;
  ImageTransformer = (function() {
    function ImageTransformer() {}
    ImageTransformer.prototype.init = function(s3, redis) {
      this.s3 = s3;
      return this.redis = redis;
    };
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
      _ref = this.s3Location(pathToImage), bucket = _ref[0], key = _ref[1];
      console.log("bucket: " + bucket + ", key: " + key);
      return finish();
    };
    ImageTransformer.prototype._transform = function(pathToImage, finish) {
      var bucket, key, s3Url, _ref;
      console.log('_transform');
      _ref = this.s3Location(pathToImage), bucket = _ref[0], key = _ref[1];
      console.log("bucket: " + bucket + ", key: " + key);
      s3Url = '';
      return finish(s3Url);
    };
    ImageTransformer.prototype.s3Location = function(request) {
      var matches, regexp;
      console.log("s3Location: " + request);
      regexp = /https?:\/\/(?:s3.amazonaws.com\/)?([^\/]*)(.*)$/;
      matches = request.match(regexp);
      return [matches[1], matches[2]];
    };
    return ImageTransformer;
  })();
  exports.ImageTransformer = ImageTransformer;
}).call(this);
