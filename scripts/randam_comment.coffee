TEMPLATE_KEY="comment_template"
NOUNS_KEY="nouns"

async = require('async')
cron = require('cron').CronJob 
client = require('redis').createClient()

# redis から取得する値一覧。
comment_template=""
noun=""
first_parson=""

# radisからデータ取ってくる関数群

# Redisのリストからランダムに一つ取ってくる。
getRanomByKeyFromRedisList = (key , keyValues, func) ->
  client.llen key , (err,count) ->
    index = Math.floor(Math.random() * count)
    client.lindex key , index , (err,value) ->
      keyValues[key] = value
      func()
  
# Redisからkeyで一つ取ってくる。
getByKeyFromRedis = (key , keyValues , func) ->
  client.get key , (err,value) ->
    keyValues[key] = value
    func()

# ランダムにしゃべる
randomSpeak = (func) -> 
    # redisから受け取る、文字情報一式の連想配列。
    keyValues = {}
    # ここから下は順次同期処理。
    async.series([
      (callback)->
        # Radisからコメントの元をランダムに取り出す。
        getRanomByKeyFromRedisList TEMPLATE_KEY , keyValues , ->
          callback null
      ,(callback)->
        # Radisから名詞をランダムに取り出す。
        getRanomByKeyFromRedisList "noun" , keyValues , ->
          callback null
      ,(callback)->
        # Radisから「一人称」を取り出す。j
        getByKeyFromRedis "first_person", keyValues , ->
          callback null
      ,(callback)->
        # 上での処理の結果を受けて、メッセージをつぶやく
        
        # メッセージのテンプレートを取り出す。
        comment_template = keyValues[TEMPLATE_KEY]

	# 連想配列をキーで回しながら、「EL式風のところ」を全部置換していく。
	# TODO なんかカッコイイテンプレートエンジンとかEL置換式とかでできたらいいな。
        comment = comment_template
        for key, value of keyValues
          comment = comment.replace("\#\{#{key}\}" , value)

        # 実際に何かする。(内容は外側で決めるから文字列だけ送っとく。)
        func comment
    ],(err, results) ->
       msg.send result
    )

# ここからが本番！
module.exports = (robot) ->
  robot.hear /.*sey.*/i, (msg) ->
    randomSpeak (comment) ->
      msg.send  comment
