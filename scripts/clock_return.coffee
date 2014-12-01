module.exports = (robot) ->
   robot.hear /.*time.*/i, (msg) ->
     msg.send "さあ？ #{new Date} ぐらいじゃない？ｗ"
