(function() {
  var Config, ImageStore, Redis, Transformer, config, imageStore, redis, router, server, transformer;
  server = require('./lib/server');
  router = require('./lib/router');
  Redis = require('redis');
  Config = require('./lib/config').Config;
  ImageStore = require('./lib/image_store').ImageStore;
  Transformer = require('./lib/image_transformer').ImageTransformer;
  config = new Config().config();
  imageStore = new ImageStore(config.imageStore);
  redis = new Redis.createClient(config.redis.port, config.redis.host);
  transformer = new Transformer(imageStore, redis);
  server.start(router.route, transformer);
}).call(this);
