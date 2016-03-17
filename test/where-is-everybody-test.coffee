chai = require 'chai'
Helper = require('hubot-test-helper')
helper = new Helper('./../src/out-of-office.coffee')
chrono = require 'chrono-node'
expect = chai.expect
chai.use(require('chai-things'))

moment = require 'moment'
momentFormat = 'ddd MMM D YYYY [at] HH:mm'


room = null
expected = "Alice Smith is on holiday until #{moment(chrono.parseDate('12/31/16')).format(momentFormat)}\nBob Jones is out of office\nJohn Smith is on business travel\nAndrew Davies is working from home\n"
console.log ("Expected #{expected}")
context 'where is everybody', ->
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
      }
    ]
    room.user.say 'alice', 'hubot I\'m on holiday till 12/31/2016'
    room.user.say 'bob', 'hubot I\'m out of office'
    room.user.say 'john', 'hubot I\'m ot'
    room.user.say 'andrew', 'hubot I\'m working from home'

  afterEach ->
    room.destroy()

  describe 'alice is on holiday until the end of the year, bob is out of office, john is on travel,  and andrew is working from home', ->
    describe 'alice asks where everybody is', ->
      beforeEach ->
        room.user.say 'alice', 'hubot where\'s everybody?'

      it 'should respond that Alice, John, Bob and Andrew are out', ->
        console.log("We got: #{room.messages}")
        console.log("We expected: #{expected}")
        expect(room.messages).to.include.something.eql ['hubot', "#{expected}"]

    describe 'bob asks where everybody is', ->    
      beforeEach ->
        room.user.say 'bob', 'hubot where is everyone'

      it 'should respond that Alice, John, Bob and Andrew are out', ->
        expect(room.messages).to.include.something.eql ['hubot', "#{expected}"]

    describe 'dave asks where everybody is', ->    
      beforeEach ->
        room.user.say 'dave', 'hubot where\'s everyone'

      it 'should respond that Alice, John, Bob and Andrew are out', ->
        expect(room.messages).to.include.something.eql ['hubot', "#{expected}"]      

    describe 'geoff asks where everybody is', ->    
      beforeEach ->
        room.user.say 'geoff', 'hubot where is everybody'

      it 'should respond that Alice, John, Bob and Andrew are out', ->
        expect(room.messages).to.include.something.eql ['hubot', "#{expected}"]   

    describe 'grace asks where everybody is', ->    
      beforeEach ->
        room.user.say 'grace', 'hubot WHERE IS EVERYBODY'

      it 'should respond that Alice, John, Bob and Andrew are out', ->
        expect(room.messages).to.include.something.eql ['hubot', "#{expected}"]      

  describe 'alice, bob and andrew are back', ->
    describe 'grace asks where everybody is', ->
      beforeEach ->
        room.user.say 'bob', 'hubot I am back'
        room.user.say 'alice', 'hubot I am back'
        room.user.say 'andrew', 'hubot I am back'
        room.user.say 'john', 'hubot I am back'
        
        room.user.say 'grace', 'hubot where\'s everybody?'

      it 'responds that everybody is in', ->
        expect(room.messages).to.include.something.eql ['hubot', "everybody should be in..."]
