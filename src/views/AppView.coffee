class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="new-game-button">New Game</button>
    <div class="num-cards"></div>
    <div class="win-loss">
      <div class="win-count"></div>
      <div class="loss-count"></div>
    </div>
    <h2 class="game-message"></h2>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': ->
      if (not @model.get('playerHand').is21())
        @model.get('playerHand').hit()
    'click .stand-button': ->
      if(not @model.get('playerHand').isBusted() and not @model.get('playerHand').is21())
        @model.get('playerHand').stand()
    'click .new-game-button': ->
      @model.newGame()
      @clearGameMessage()

  initialize: ->
    @model.on 'end-game', =>
      @renderGameOver()
    @model.get('playerHand').on 'new-card-count', =>
      @renderCardCount()
    @model.get('dealerHand').on 'new-card-count', =>
      @renderCardCount()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.num-cards').text('Card Count: ' + @model.get('playerHand').deck.models.length)
    @$('.win-count').text('Wins: ' + @model.get('playerHand').wins)
    @$('.loss-count').text('Loss: ' +@model.get('playerHand').losses)

  renderCardCount: ->
    @$('.num-cards').text('Card Count: ' + @model.get('playerHand').deck.models.length)

  # renderWinLossCount: ->

  renderGameOver: ->
    if @model.determineWinner() == 0
      message = 'The Game is a Push'
    else if @model.determineWinner() == 1
      message = 'You Win!'
      @model.get('playerHand').wins++
    else
      message = 'You Lose'
      @model.get('playerHand').losses++
    @$('.win-count').text('Wins: ' + @model.get('playerHand').wins)
    @$('.loss-count').text('Loss: ' + @model.get('playerHand').losses)
    @$('.game-message').text(message)

  clearGameMessage: ->
    @$('.game-message').empty()
