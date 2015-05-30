class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="new-game-button">New Game</button>
    <div class="num-cards"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': ->
      if(not @model.get('playerHand').isBusted() and not @model.get('playerHand').is21())
        # console.log @model.get('playerHand').scores()
        @model.get('playerHand').stand()
    'click .new-game-button': -> @model.newGame()

  initialize: ->
    @render()
    @model.on 'end-game', =>
      console.log('Im rendering end of game')
      @renderGameOver()
    @model.get('playerHand').on 'new-card-count', =>
      @renderCardCount()
    @model.get('dealerHand').on 'new-card-count', =>
      @renderCardCount()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.num-cards').text('Card Count: ' + @model.get('playerHand').deck.models.length)

  renderCardCount: ->
    @$('.num-cards').text('Card Count: ' +@model.get('playerHand').deck.models.length)

  renderGameOver: ->
    if @model.get('playerHand').currentScore() == @model.get('dealerHand').currentScore()
      message = 'The Game is a Push'
    else if @model.get('playerHand').currentScore() > @model.get('dealerHand').currentScore()
      message = 'You Win!'
    else
      message = 'You Lose'
    @$('.num-cards').append('<div>' + message + '</div>')
