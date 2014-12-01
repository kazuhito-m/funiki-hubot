# cron = require('cron').CronJob 

client = require('redis').createClient()

module.exports = (robot) ->
#   new cron('0 0 * * * *', () ->
#     envelope = room: "#dummy"
#     robot.send envelope, "@kazuhito_m ただいま、 #{new Date} をお知らせします。"
#   ).start()
  robot.hear /.*sey.*/i, (msg) ->
    client.get "test", (err, val) ->
      msg.send val
    client.llen "comment_template" , (err,val2) ->
      msg.send val2
