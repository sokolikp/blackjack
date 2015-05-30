assert = chai.assert

describe 'hand', ->
  deck = null
  hand = null
  handDealer = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    handDealer = deck.dealDealer()
    return

  describe 'dealer check', ->
    it 'player should not be the dealer', ->
      assert.strictEqual hand.isDealer, undefined
      return
    it 'dealer should be the dealer', ->
      assert.strictEqual handDealer.isDealer, true
      return
    return
  return

