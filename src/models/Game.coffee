# # TODO: Refactor this model to use an internal Game Model instead
# # of containing the game logic directly.
# class window.Game extends Backbone.Model
#   initialize: ->
#     # numStands = 0;
#     # @set 'deck', deck = new Deck()
#     # @set 'playerHand', deck.dealPlayer()
#     # @set 'dealerHand', deck.dealDealer()

#     # @get('playerHand').on 'busted', ->
#     #   # console.log 'dealing a new hand'
#     #   # @set 'playerHand', deck.dealPlayer()
#     #   # @set 'dealerHand', deck.dealDealer()
#     #   @newGame()
#     # , @

#     # @get('playerHand').on 'stand', ->
#     #   if numStands == 0
#     #     @get('dealerHand').at(0).flip()
#     #     if(@get('dealerHand').scores()[0] < 17 and @get('dealerHand').scores()[1] < 17)
#     #       @get('dealerHand').hit()
#     #   numStands++
#     # , @
#     @set 'app', app = new App()

#   newGame: ->
#     #begin a new game
#     @set 'playerHand', deck.dealPlayer()
#     @set 'dealerHand', deck.dealDealer()

