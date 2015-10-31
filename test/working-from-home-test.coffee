chai = require 'chai'
Helper = require('hubot-test-helper')
helper = new Helper('./../src/out-of-office.coffee')

expect = chai.expect
chai.use(require('chai-things'))

room = null
describe 'users are working from home', ->
  beforeEach ->
    room = helper.createRoom()

  afterEach ->
    room.destroy()

  describe 'alice works from home', ->
    beforeEach ->
      room.user.say 'alice', 'hubot I\'m wfh'

    it 'responds that alice is working from home', ->
      expect(room.messages).to.include.something.eql ['hubot', '@alice working from home']   
  
  describe 'bob works from home', ->
    beforeEach ->
      room.user.say 'bob', 'hubot I\'m working from home'

    it 'responds that bob is working from home', ->
      expect(room.messages).to.include.something.eql ['hubot', '@bob working from home']       

  describe 'dave works from home', ->
    beforeEach ->
      room.user.say 'dave', 'hubot I am working from home'

    it 'responds that dave is working from home', ->
      expect(room.messages).to.include.something.eql ['hubot', '@dave working from home']  

  describe 'geoff works from home', ->
    beforeEach ->
      room.user.say 'geoff', 'hubot I\'m working from home'

    it 'responds that geoff is working from home', ->
      expect(room.messages).to.include.something.eql ['hubot', '@geoff working from home']  

  describe 'grace works from home', ->
    beforeEach ->
      room.user.say 'grace', 'hubot I\'M WORKING FROM HOME'

    it 'responds that grace is working from home', ->
      expect(room.messages).to.include.something.eql ['hubot', '@grace working from home']  
