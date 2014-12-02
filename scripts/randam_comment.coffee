TEMPLATE_KEY="comment_template"

cron = require('cron').CronJob 
client = require('redis').createClient()

module.exports = (robot) ->
#   new cron('0 0 * * * *', () ->
#     envelope = room: "#dummy"
#     robot.send envelope, "@kazuhito_m ただいま、 #{new Date} をお知らせします。"
#   ).start()
  robot.hear /.*sey.*/i, (msg) ->
    # Test
    client.get "test", (err, val) ->
      msg.send val

    # ランダムにしゃべる
    client.llen TEMPLATE_KEY , (err,count) ->
      index = Math.floor(Math.random() * count)
      client.lindex TEMPLATE_KEY , index , (err,comment) ->
        msg.send comment

