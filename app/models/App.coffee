#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'bust', @playerLoses, @
    @get('dealerHand').on 'bust', @playerWins, @
    @get('playerHand').on 'stand', @dealerPlays, @
  playerLoses: -> #player loses,
    @trigger 'lose'
  playerWins: ->
    @trigger 'win'
  dealerPlays: -> 
    playerScore = @get('playerHand').score()
    while @get('dealerHand').score() < playerScore 
      @get('dealerHand').hit()
    @playerLoses()

  #dealer plays