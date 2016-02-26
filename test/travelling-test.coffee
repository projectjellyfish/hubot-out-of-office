chai = require 'chai'
Helper = require('hubot-test-helper')
helper = new Helper('./../src/out-of-office.coffee')

expect = chai.expect
chai.use(require('chai-things'))

room = null
describe 'users go on business travel', ->
  beforeEach ->
    room = helper.createRoom()

  afterEach ->
    room.destroy()

  describe 'alice goes on business travel', ->
    beforeEach ->
      room.user.say 'alice', 'hubot I\'m ot'

    it 'responds that alice is on business travel', ->
      expect(room.messages).to.include.something.eql ['hubot', '@alice on business travel']   
  
  describe 'bob goes on business travel', ->
    beforeEach ->
      room.user.say 'bob', 'hubot I\'m traveling'

    it 'responds that bob is on business travel', ->
      expect(room.messages).to.include.something.eql ['hubot', '@bob on business travel']       

  describe 'dave goes on business travel', ->
    beforeEach ->
      room.user.say 'dave', 'hubot I am on travel'

    it 'responds that dave is on business travel', ->
      expect(room.messages).to.include.something.eql ['hubot', '@dave on business travel']  

  describe 'geoff goes on business travel', ->
    beforeEach ->
      room.user.say 'geoff', 'hubot I\'m traveling'

    it 'responds that geoff is on business trave', ->
      expect(room.messages).to.include.something.eql ['hubot', '@geoff on business travel']  

  describe 'grace goes on business travel', ->
    beforeEach ->
      room.user.say 'grace', 'hubot I\'M ON TRAVEL'

    it 'responds that grace is on business trave', ->
      expect(room.messages).to.include.something.eql ['hubot', '@grace on business travel']  
