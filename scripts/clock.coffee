cron = require('cron').CronJob

console.log process.env.HUBOT_INTERVAL

module.exports = (robot) ->
  new cron('0 0 * * * *', () ->
    envelope = room: "#dummy"
    robot.send envelope, "@kazuhito_m ただいま、 #{new Date} をお知らせします。"
  ).start()
