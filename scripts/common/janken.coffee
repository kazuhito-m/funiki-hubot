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
    # 自分の手から相手の手を引き算し、絶対値で２超えてるものは「上限を超えたもの」なんで、符号裏返して１にする。
    # 数列としては、1,-1,0,1,-1... の繰り返しを作り出す。
    ((myHand - enemyHand + 4) % 3) - 1

  # 「じゃんけん」の試合メソッド(片方の手が自動に成るタイプ)
  buttleAuto: (oneHand)->
    this.buttle(oneHand, this.hand())

# 上記のクラス、定数群を外部参照可能なようにエクスポート
exports.Janken = Janken
exports.Sign = Sign
exports.Result = Result
