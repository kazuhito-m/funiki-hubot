cron = require('cron').CronJob

module.exports = (robot) ->
  new cron('0 0 * * * *', () ->
    envelope = room: "#dummy"
    robot.send envelope, "ただいま、 #{new Date} をお知らせします。"
  ).start()

   robot.hear /.*(time|時間|じかん).*/i, (msg) ->
     msg.send "さあ？ #{new Date} ぐらいじゃない？ｗ"
