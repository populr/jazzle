(function() {
  var route;
  route = function(pathname, imageTransformer, response) {
    console.log("About to route a request for " + pathname);
    if (/^\/refresh/.test(pathname)) {
      console.log("clearCache");
      return imageTransformer.clearCache(pathname, response);
    } else if (/^\/\d/.test(pathname)) {
      console.log("transform");
      return imageTransformer.transform(pathname, response);
    } else {
      response.writeHead(404);
      return response.end();
    }
  };
  exports.route = route;
}).call(this);
