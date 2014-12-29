expect = require('chai').expect

# テスト対象のクラス定義自体を引っ張ってきて、同名で定義
Janken = require('../../scripts/common/janken').Janken

describe 'じゃんけん処理のテスト', ->  
  it '単純なグーチョキパーで判定出来る', (done) ->
    sut = new Janken()
    expect(sut.buttle(0,1)).to.equal('かち')
    done()
  it 'グーチョキパーをランダムで出す', (done) ->
    sut = new Janken()
    expect(sut.hand()).to.equal(0)
    done()
