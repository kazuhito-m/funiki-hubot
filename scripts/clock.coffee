cron = require('cron').CronJob

module.exports = (robot) ->
  # 一時間ごとの定時連絡
  new cron('0 0 * * * *', () ->
    envelope = room: "#dummy"
    robot.send envelope, "ただいま、 #{new Date} をお知らせします。"
  ).start()

  # 時間は？ときかれた際の反応。
  robot.hear /.*(time|時間|じかん).*/i, (msg) ->
    msg.send "さあ？ #{new Date} ぐらいじゃない？ｗ"
