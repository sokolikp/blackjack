# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'busted', ->
      console.log 'Im in busted'
      @set 'playerHand', deck.dealPlayer()
      # console.log(@get('playerHand'))
      @set 'dealerHand', deck.dealDealer()
      # console.log(@get('dealerHand'))
    , @

    # @get 'playerHand'.addEventListener 'busted', (e) =>
    #   this.clickHandler(e)

