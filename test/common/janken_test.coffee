expect = require('chai').expect

# テスト対象のクラス定義自体を引っ張ってきて、同名で定義
Janken = require('../../scripts/common/janken').Janken
Sign = require('../../scripts/common/janken').Sign
Result = require('../../scripts/common/janken').Result

# ヘルパ関数「連想配列の要素内に対象の値があるか」
isExistValue = (table, value) ->
  hit = false
  for key ,i of table 
    if i == value
      hit = true
  hit

describe 'じゃんけん処理のテスト', ->  

  # テスト対象
  sut = new Janken()  # 状態を持たないので、一々作成・破棄しなくてもOK…だと思う。

  it '単純なグーチョキパーで判定出来る', (done) ->
    expect(sut.buttle(Sign.ty,Sign.pa)).to.equal(Result.win)
    done()

  it 'じゃんけんして自分が勝つパターン', (done) ->
    res = Result.win
    expect(sut.buttle(Sign.gu,Sign.ty)).to.equal(res)
    expect(sut.buttle(Sign.ty,Sign.pa)).to.equal(res)
    expect(sut.buttle(Sign.pa,Sign.gu)).to.equal(res)
    done()

  it 'じゃんけんして自分が負けるパターン', (done) ->
    res = Result.loss
    expect(sut.buttle(Sign.gu,Sign.pa)).to.equal(res)
    expect(sut.buttle(Sign.ty,Sign.gu)).to.equal(res)
    expect(sut.buttle(Sign.pa,Sign.ty)).to.equal(res)
    done()

  it 'じゃんけんしてあいこになるパターン', (done) ->
    res = Result.drow
    expect(sut.buttle(Sign.gu,Sign.gu)).to.equal(res)
    expect(sut.buttle(Sign.ty,Sign.ty)).to.equal(res)
    expect(sut.buttle(Sign.pa,Sign.pa)).to.equal(res)
    done()

  it 'グーチョキパーをランダムで出す', (done) ->
    # Signの範囲内のものを返すかテスト(ランダムの信頼性確保のため多数回回す)
    for i in [0..1000]
      actual = isExistValue(Sign, sut.hand())
      expect(actual).to.true
    done()

  it '自分(他者？)の手が自動的に出るようなじゃんけんが可能である', (done) ->
    # 勝ち、負け、あいこの範囲内で返すかテスト(ランダムの信頼性確保のため多数回回す)
    for i in [0..1000]
      actual = isExistValue(Result, sut.buttleAuto(Sign.gu))
      expect(actual).to.true
    done()

