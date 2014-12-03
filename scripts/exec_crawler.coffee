# scala製のクロールプログラムを実行する。
# "クロールしろ" と言われれば即時、そうでなければ日に一回起動する。

# 定数系

# クロールを実行するシェル。(Hubotディレクトリ直下がカレントであることを期待。)
EXEC_COMMAND = './opt/crawler/exec_crawler.bsh'

# 実行頻度
EXEC_INTERVAL = '0 0 4 * * *' #毎朝四時くらいでいいか。

# インポート系
child_process = require 'child_process'
cron = require('cron').CronJob 

# 広域変数
is_executing = false

# scalaバッチのシェルスクリプトをキックする。
execScript = ->
 is_executing = true
 child_process.exec EXEC_COMMAND, (error, stdout, stderr) ->
  if !error
    console.log 'クロールを開始します。'
    output = stdout+''
    console.log output
    is_executing = false
  else
    console.log '実行は失敗しました。'
    is_executing = false

# ここからが本番！

module.exports = (robot) ->
  # cronスケジューリングによる自動Twilogクロール
  new cron( EXEC_INTERVAL , () ->
    if is_executing
      console.log 'クロールはすでに実行中のため、スキップしました。'
    else 
      execScript()
  ).start()

  # メンションによる処理(なんか言え！とか言われたら)
  robot.hear /.*(クロール[しせ]|exec crawl).*/i, (msg) ->
    if is_executing
      msg.send '残念、今やってるみたいだ。'
    else
      msg.send 'ガッテン！およぐぜ！'
      execScript()

