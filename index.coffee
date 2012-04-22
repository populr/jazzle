server = require('./lib/server')
router = require('./lib/router')
Config = require('./lib/config').Config
S3 = require('./lib/image_store').ImageStore
Redis = require('redis').Redis
Transformer = require('./lib/image_transformer').ImageTransformer

config = new Config().config()
s3 = new S3(config.aws.public, config.aws.secret)
redis = new Redis().createClient(config.redis.port, config.redis.host)
transformer = new Transformer(s3, redis)

server.start(router.route, transformer)