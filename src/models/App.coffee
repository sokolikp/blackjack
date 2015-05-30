# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    numStands = 0;
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'busted', ->
      console.log('busted')
    , @

    @get('dealerHand').on 'busted', ->
      console.log('busted')
    , @

    @get('playerHand').on 'game-over', ->
      console.log('game over!')
    , @

    @get('dealerHand').on 'game-over', ->
      console.log('game over!')
    , @

    @get('playerHand').on 'stand', ->
      if numStands == 0
        @get('dealerHand').at(0).flip()
        @get('dealerHand').hit()
      numStands++
    , @

  newGame: (deck) ->
    @get('playerHand').newRound()
    @get('dealerHand').newRound()

