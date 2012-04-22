userConfig = require('../config').Configuration

class Config

  config: () ->
    if process.env.REDISTOGO_URL?
      regexp = /redis:\/\/(.+?):(\d+)\//
      matches = process.env.REDISTOGO_URL.match(regexp)
      userConfig.redis.port = matches[1]
      userConfig.redis.host = matches[2]

    if process.env.AWS_KEY?
      userConfig.aws.public = process.env.AWS_KEY
      userConfig.aws.secret = process.env.AWS_SECRET

    userConfig


exports.Config = Config