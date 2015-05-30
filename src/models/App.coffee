# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    # numStands = 0;
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'busted game-over', ->
      console.log 'game over'
      @trigger 'end-game', @

    @get('dealerHand').on 'buster game-over', ->
      console.log 'game over'
      @trigger 'end-game', @

    @get('playerHand').on 'stand', ->
      console.log 'standing'
      if @get('playerHand').stands == 1
        @get('dealerHand').at(0).flip()
        @get('dealerHand').hit()
      # numStands++
    , @

  newGame: (deck) ->
    if(@get('deck').length <= 14)
      @get('deck').newDeck()
    @get('playerHand').newRound()
    @get('dealerHand').newRound()

