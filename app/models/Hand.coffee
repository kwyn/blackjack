class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: -> 
    @add(@deck.pop())
    if @busted() then @trigger 'bust'
    @last()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  busted: ->
    currentScore = @scores()
    currentScore = if (currentScore[1] isnt undefined)
      if  currentScore[1] > 21 
        currentScore[0] 
      else 
        currentScore[1]
    else currentScore[1]
    currentScore > 21  
