class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> \
  (<span class="score"></span>)<span class="win-busted"></span></h2>'

  initialize: ->
    @collection.on 'add remove change', =>
      # console.log('re-rendering')
      @render()
    @render()

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
        ' Busted!!1'
      else if @collection.scores()[0] is 21 or @collection.scores()[1] is 21
        ' Twenty-one!')

