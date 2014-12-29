# じゃんけんを行うクラス
 
# じゃんけんの手
Sign = 
  pa : 0
  ty : 1
  gu : 2

# じゃんけんの結果
Result = 
  win : 1
  loss : -1
  drow : 0

class Janken
  # 「じゃんけんの手」を取得する。
  #   3つの手をランダムに返す。
  hand: ->
    0

  # 「じゃんけん」の試合メソッド
  buttle: (myHand , enemyHand)->
    # まず、手を引き算する。
    result = myHand - enemyHand  
    # 絶対値で２超えてるものは生き過ぎたものなんで、符号裏返して１にする。
    if Math.abs(result) >= 2 then (result / -2) else result

# 上記のクラス、定数群を外部参照可能なようにエクスポート
exports.Janken = Janken
exports.Sign = Sign
exports.Result = Result
