assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null
  handDealer = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    handDealer = deck.dealDealer()
    return

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 48
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 47
      return

    it '(Dealer\'s turn) should give the last card from the deck', ->
      assert.strictEqual deck.last(), handDealer.hit()
      assert.strictEqual deck.length, 46
      return
    return
  return

