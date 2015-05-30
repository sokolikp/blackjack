class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
  stands: 0

  hit: ->
    # console.log 'hit'
    # console.log @scores()
    # console.log @stands
    if @scores()[0] < 21 and @scores()[1] != 21 and @stands == 0
      newCard = @deck.pop()
      @add(newCard)
      if @isBusted()
        @trigger 'busted', @
      else if @isDealer
        if(@scores()[1] < 17 or (@scores()[1] > 21 and @scores()[0] < 17))# or @scores()[0] < 17)
          @hit()
        else
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

  currentScore: ->
    if @scores()[1] <= 21
      @scores()[1]
    else
      @scores()[0]

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  isBusted: ->
    if @scores()[0] > 21 then true else false

  is21: ->
    console.log()
    if @scores()[0] == 21 or @scores[1] == 21
      console.log('I\'m 21')
      true
    else
      false

  newRound: ->
    @stands = 0
    newCard = @deck.pop()
    if @isDealer then newCard.flip()
    for i in [0..@length]
      @remove(@at(0))
    @add newCard
    @add @deck.pop()

  updateCardCount: ->
    @trigger 'new-card-count', @
