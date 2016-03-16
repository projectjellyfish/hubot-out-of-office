chai = require 'chai'
Helper = require('hubot-test-helper')
helper = new Helper('./../src/out-of-office.coffee')
chrono = require 'chrono-node'

expect = chai.expect
chai.use(require('chai-things'))

room = null
expected = "Alice Smith is on holiday\nBob Jones is out of office\nJohn Smith is on business travel\nAndrew Davies is working from home\nJason Voorhees is on business travel until #{chrono.parseDate('12/31/16')}\n"

context 'reset status for everyone', ->
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
        name: "john"
        real_name: "John Smith"
      }   
      {
        name: "andrew"
        real_name: "Andrew Davies"
      },
      {
        name: "jason"
        real_name: "Jason Voorhees"
      }
    ]

    room.user.say 'jason', 'hubot I\'m ot till 12/31/16'
    room.user.say 'alice', 'hubot I\'m on holiday'
    room.user.say 'bob', 'hubot I\'m out of office'
    room.user.say 'john', 'hubot I\'m ot'
    room.user.say 'andrew', 'hubot I\'m working from home'


  afterEach ->
    room.destroy()

  describe 'alice is on holiday, bob is out of office, john is on travel,  and andrew is working from home', ->
    describe 'alice asks where everybody is', ->
      beforeEach ->
        room.user.say 'alice', 'hubot where\'s everybody?'

      it 'should respond that Alice, John, Bob and Andrew are out', ->
        console.log(room.messages)
        console.log(expected)
        expect(room.messages).to.include.something.eql ['hubot', "#{expected}"]

   
  describe 'everyone\'s status is reset to in', ->
    describe 'grace resets status', ->
      beforeEach ->
        room.user.say 'grace', 'hubot reset'        
        
      it 'responds that everybody is in', ->
        # console.log(room.messages)
        expect(room.messages).to.include.something.eql ['hubot', "It\'s a new day!\nEveyone\'s in who should be in!"]

