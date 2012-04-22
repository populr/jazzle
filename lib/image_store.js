(function() {
  var ImageStore, async, sunny;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  sunny = require('sunny');
  async = require('async');
  ImageStore = (function() {
    ImageStore.prototype.store = null;
    function ImageStore(config) {
      var sunnyCfg;
      sunnyCfg = sunny.Configuration.fromObj(config);
      this.store = sunnyCfg.connection;
    }
    ImageStore.prototype.storeImage = function(localPath, bucketName, s3Path, success, error) {
      var container;
      container = null;
      return async.series([
        __bind(function(callback) {
          var request;
          request = this.store.getContainer(bucketName);
          request.on('error', error);
          request.on('end', function(results, metadata) {
            container = results.container;
            return callback(null);
          });
          return request.end();
        }, this), __bind(function(callback) {
          var request;
          request = container.putBlobFromFile(s3Path, localPath);
          request.on('error', error);
          request.on('end', function(results, metadata) {
            return callback(null);
          });
          return request.end();
        }, this)
      ], function(err) {
        if (err != null) {
          return error(err);
        } else {
          return success();
        }
      });
    };
    ImageStore.prototype.getImage = function(bucketName, s3Path, localPath, success, error) {
      var container;
      container = null;
      return async.series([
        __bind(function(callback) {
          var request;
          request = this.store.getContainer(bucketName);
          request.on('error', error);
          request.on('end', function(results, metadata) {
            container = results.container;
            return callback(null);
          });
          return request.end();
        }, this), function(callback) {
          var request;
          request = container.getBlobToFile(s3Path, localPath);
          request.on('error', error);
          request.on('end', function(results, metadata) {
            return callback(null);
          });
          return request.end();
        }
      ], function(err) {
        if (err != null) {
          return error(err);
        } else {
          return success();
        }
      });
    };
    return ImageStore;
  })();
  exports.ImageStore = ImageStore;
}).call(this);
