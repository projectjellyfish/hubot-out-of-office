chai = require 'chai'
Helper = require('hubot-test-helper')
chrono = require 'chrono-node'
moment = require 'moment'
momentFormat = 'ddd MMM D YYYY [at] HH:mm'

helper = new Helper('./../src/out-of-office.coffee')
expect = chai.expect
chai.use(require('chai-things'))

room = null
expected = "Alice Smith is on holiday\nBob Jones is out of office\nJohn Smith is on business travel\nAndrew Davies is working from home\nJason Voorhees is on business travel until #{moment(chrono.parseDate('12/31/16')).format(momentFormat)}\n"
resetExpected = "It's a new day!  The team is in except for:\nJason Voorhees is on business travel until #{moment(chrono.parseDate('12/31/16')).format(momentFormat)}\n"
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
        # console.log(room.messages)
        # console.log(expected)
        expect(room.messages).to.include.something.eql ['hubot', "#{expected}"]

   
  describe 'everyone\'s status is reset to in except for Jason', ->
    describe 'grace resets status', ->
      beforeEach ->
        room.user.say 'grace', 'hubot reset'        
        
      it 'responds that everybody is in, except for Jason', ->
        console.log("We got: #{room.messages}")
        console.log("We expected: #{resetExpected}")
        expect(room.messages).to.include.something.eql ['hubot', "#{resetExpected}"]
   
  describe 'everyone\'s status is hard reset', ->
    describe 'grace resets status', ->
      beforeEach ->
        room.user.say 'grace', 'hubot HARDRESET'        
        
      it 'Forced Reset Done, everybody is in!', ->
        console.log("We got: #{room.messages}")
        console.log("We expected: #{resetExpected}")
        expect(room.messages).to.include.something.eql ['hubot', "Forced Reset Done, everybody is in!"]

