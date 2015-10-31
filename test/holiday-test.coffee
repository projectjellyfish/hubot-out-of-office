chai = require 'chai'
Helper = require('hubot-test-helper')
helper = new Helper('./../src/out-of-office.coffee')

expect = chai.expect
chai.use(require('chai-things'))

room = null
describe 'users go on holiday', ->
  beforeEach ->
    room = helper.createRoom()
    room.robot.brain.data.users = [
      {
        name: "alice"
        real_name: "Alice Smith"
      }
      {
        name: "bob"
        real_name: "Bob Jones"
      }
      {
        name: "grace"
        real_name: "Grace Davies"
        }
      ]

  afterEach ->
    room.destroy()

  describe 'users go on holiday', ->
    describe 'alice goes on holiday', ->
        beforeEach ->
          room.user.say 'alice', 'hubot I\'m on holiday'

        it 'responds that alice is on holiday', ->
          expect(room.messages).to.include.something.eql ['hubot', '@alice on holiday']   
      
    describe 'bob goes on vacation', ->
      beforeEach ->
        room.user.say 'bob', 'hubot I\'m on vacation'

      it 'responds that bob is on holiday', ->
        expect(room.messages).to.include.something.eql ['hubot', '@bob on holiday']       

    describe 'dave goes on holiday', ->
      beforeEach ->
        room.user.say 'dave', 'hubot I am on holiday'

      it 'responds that dave is on holiday', ->
        expect(room.messages).to.include.something.eql ['hubot', '@dave on holiday']  

    describe 'geoff goes on vacation', ->
      beforeEach ->
        room.user.say 'geoff', 'hubot I am on vacation'

      it 'responds that geoff is on holiday', ->
        expect(room.messages).to.include.something.eql ['hubot', '@geoff on holiday']  

    describe 'grace goes on vacation', ->
      beforeEach ->
        room.user.say 'grace', 'hubot I AM ON VACATION'

      it 'responds that grace is on holiday', ->
        expect(room.messages).to.include.something.eql ['hubot', '@grace on holiday']

  context 'user tells hubot they are back', ->
    beforeEach ->
      room.user.say 'alice', 'hubot I\'m on holiday'
      room.user.say 'bob', 'hubot I\'m out of office'
      room.user.say 'andrew', 'hubot I\'m out of office'
      room.user.say 'alice', 'hubot I\'m back'
      room.user.say 'bob', 'hubot I am back'
      room.user.say 'dave', 'hubot I AM BACK'

    it 'responds <user> welcome back!', ->
      expect(room.messages).to.include.something.eql ['hubot', '@alice welcome back!']
      expect(room.messages).to.include.something.eql ['hubot', '@bob welcome back!']
      expect(room.messages).to.include.something.eql ['hubot', '@dave welcome back!']

      expect(room.robot.brain.get("alice.ooo")).to.be.null
      expect(room.robot.brain.get("bob.ooo")).to.be.null
      expect(room.robot.brain.get("andrew.ooo")).to.equal("out of office")
