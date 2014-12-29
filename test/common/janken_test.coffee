expect = require('chai').expect

# テスト対象のクラス定義自体を引っ張ってきて、同名で定義
Janken = require('../../scripts/common/janken').Janken
Sign = require('../../scripts/common/janken').Sign
Result = require('../../scripts/common/janken').Result

describe 'じゃんけん処理のテスト', ->  

  it '単純なグーチョキパーで判定出来る', (done) ->
    sut = new Janken()
    expect(sut.buttle(Sign.ty,Sign.pa)).to.equal(Result.win)
    done()

  it 'じゃんけんして自分が勝つパターン', (done) ->
    sut = new Janken()
    res = Result.win
    expect(sut.buttle(Sign.gu,Sign.ty)).to.equal(res)
    expect(sut.buttle(Sign.ty,Sign.pa)).to.equal(res)
    expect(sut.buttle(Sign.pa,Sign.gu)).to.equal(res)
    done()

  it 'じゃんけんして自分が負けるパターン', (done) ->
    sut = new Janken()
    res = Result.loss
    expect(sut.buttle(Sign.gu,Sign.pa)).to.equal(res)
    expect(sut.buttle(Sign.ty,Sign.gu)).to.equal(res)
    expect(sut.buttle(Sign.pa,Sign.ty)).to.equal(res)
    done()

  it 'じゃんけんしてあいこになるパターン', (done) ->
    sut = new Janken()
    res = Result.drow
    expect(sut.buttle(Sign.gu,Sign.gu)).to.equal(res)
    expect(sut.buttle(Sign.ty,Sign.ty)).to.equal(res)
    expect(sut.buttle(Sign.pa,Sign.pa)).to.equal(res)
    done()

  it 'グーチョキパーをランダムで出す', (done) ->
    sut = new Janken()
    expect(sut.hand()).to.equal(0)
    done()
