# 相手のメンションが、Radisで設定したキーワードに合致した場合に条件反射でメンションを返す。

# 定数

TEMPLATE_KEY='dog_of_pavlov'

# 前準備、Redisクライアント用意
client = require('redis').createClient()

# Redisから条件のLISTを配列で一撃で持ってくる
key = TEMPLATE_KEY
templates = null
client.llen key , (err,count) ->
  client.lrange key , 0 , count-1 , (err,value) ->
    templates = value

# 本処理
module.exports = (robot) ->
 # とりあえず「何が投げられても」拾って、自力で正規表現で判定する。
 robot.hear /.*/i, (msg) ->
   twitterId = msg.envelope.user.name
   menthion = msg.message

   # 予め取得したテンプレート(CSV)を全件回しながら
   for i in templates
     [id , regex , comment] = i.split(",")
     # id未指定 or 一致したら
     hitId = id.trim().length == 0 || twitterId == id
     # もしくは、regex未指定 or 正規表現にひっかかったら
     hitRgx = regex.trim().length == 0 || ///#{regex}///.test(menthion)

     # 指定されていた条件に、どちらかにあてはまってたら、条件反射してしまうコメントをつぶやく
     if hitId && hitRgx
       msg.send "@#{twitterId} #{comment}"
       break

