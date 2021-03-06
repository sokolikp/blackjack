class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> \
  (<span class="score"></span>)<span class="win-busted"></span></h2>'

  initialize: ->
    @render()
    @collection.on 'add remove change', =>
      @render()
      @collection.updateCardCount()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text(
      if @collection.scores()[1] > 21
        @collection.scores()[0]
      else
        @collection.scores()[1]
    )
    @$('.win-busted').text(
      if @collection.isBusted()
        @collection.winBustedMessage)
