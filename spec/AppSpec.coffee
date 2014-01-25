describe 'App', ->
  
  app = null
  

  beforeEach ->
    app = new App()

  describe 'player', ->
    it "should have method bust and stand", ->
      expect(typeof App.prototype.playerBust).toBe('function')
      expect(typeof App.prototype.playerStand).toBe('function')