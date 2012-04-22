(function() {
  var http, start, url;
  http = require('http');
  url = require('url');
  start = function(route, imageTransformer) {
    var onRequest;
    onRequest = function(request, response) {
      var pathname;
      pathname = url.parse(request.url).pathname;
      return route(pathname, imageTransformer, response);
    };
    http.createServer(onRequest).listen(8888);
    return console.log('image transformer has started');
  };
  exports.start = start;
}).call(this);
