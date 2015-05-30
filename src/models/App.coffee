# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    gameOver: false

    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'busted game-over twenty-one', =>
      @gameOver = true
      @trigger 'end-game'

    @get('dealerHand').on 'busted game-over twenty-one', =>
      @gameOver = true
      @trigger 'end-game'

    @get('playerHand').on 'stand', =>
      if @get('playerHand').stands == 1 and not @gameOver
        @get('dealerHand').at(0).flip()
        @get('dealerHand').hit()
      # numStands++

  newGame: () ->
    @gameOver = false
    if(@get('deck').length <= 14)
      @get('deck').newDeck()
    @get('playerHand').newRound()
    @get('dealerHand').newRound()
    @get('playerHand').is21()

  determineWinner: () ->
    if @get('playerHand').isBusted()
      return -1
    else if @get('dealerHand').isBusted()
      return 1
    else if @get('playerHand').currentScore() == @get('dealerHand').currentScore()
      return 0 #message = 'The Game is a Push'
    else if @get('playerHand').currentScore() > @get('dealerHand').currentScore()
      return 1
    else
      return -1

