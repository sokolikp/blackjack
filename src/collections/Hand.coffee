class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
  stands: 0

  hit: ->
    if @scores()[0] < 21 and @stands == 0
      newCard = @deck.pop()
      @add(newCard)
      if @isBusted()
        @trigger 'busted', @
      else if @isDealer
        if(@scores()[1] < 17 or (@scores()[1] > 17 and @scores()[0] < 17))# or @scores()[0] < 17)
          @hit()
        else
          console.log('in HANDS game over')
          @trigger 'game-over', @

  stand: ->
    @stands++
    @trigger 'stand', @

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  isBusted: ->
    # console.log 'I\'b busted and my score is', @scores()
    if @scores()[0] > 21 then true else false

  newRound: ->
    # debugger
    console.log('in new Round')
    @models = [@deck.pop(), @deck.pop()]
