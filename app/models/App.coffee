#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'bust', @playerLoses, @
    @get('dealerHand').on 'bust', @playerWins, @
    @get('playerHand').on 'stand', @dealerPlays, @
    if @get('wins') is undefined then @set 'wins', 0
    if @get('losses') is undefined then @set 'losses', 0
    debugger

  playerLoses: -> #player loses,
    @set 'wins', @get('wins')+1
    @trigger 'lose'
  playerWins: ->
    @set 'loses', @get('loses')+1
    @trigger 'win'
  dealerPlays: -> 
    playerScore = @get('playerHand').score()
    while @get('dealerHand').score() < playerScore 
      @get('dealerHand').hit()
    @playerLoses()
  #dealer plays