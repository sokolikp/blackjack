class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: ->
    console.log 'I\'m dealing a new player hand'
    new Hand [@pop(), @pop()], @


  dealDealer: ->
    console.log 'I\'m dealing a new dealer hand'
    new Hand [@pop().flip(), @pop()], @, true

  # shuffle: -> @.shuffle()


