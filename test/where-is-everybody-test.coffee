chai = require 'chai'
Helper = require('hubot-test-helper')
helper = new Helper('./../src/out-of-office.coffee')

expect = chai.expect
chai.use(require('chai-things'))

room = null
expected = "Alice Smith is on holiday\nBob Jones is out of office\nAndrew Davies is working from home\n"

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
        name: "andrew"
        real_name: "Andrew Davies"
        }
      ]
    room.user.say 'alice', 'hubot I\'m on holiday'
    room.user.say 'bob', 'hubot I\'m out of office'
    room.user.say 'andrew', 'hubot I\'m working from home'

  afterEach ->
    room.destroy()

  describe 'alice is on holiday, bob is out of office, and andrew is working from home', ->
    describe 'alice asks where everybody is', ->
      beforeEach ->
        room.user.say 'alice', 'hubot where\'s everybody?'

      it 'should respond that Alice, Bob and Andrew are out', ->
        expect(room.messages).to.include.something.eql ['hubot', "#{expected}"]

    describe 'bob asks where everybody is', ->    
      beforeEach ->
        room.user.say 'bob', 'hubot where is everyone'

      it 'should respond that Alice, Bob and Andrew are out', ->
        expect(room.messages).to.include.something.eql ['hubot', "#{expected}"]

    describe 'dave asks where everybody is', ->    
      beforeEach ->
        room.user.say 'dave', 'hubot where\'s everyone'

      it 'should respond that Alice, Bob and Andrew are out', ->
        expect(room.messages).to.include.something.eql ['hubot', "#{expected}"]      

    describe 'geoff asks where everybody is', ->    
      beforeEach ->
        room.user.say 'geoff', 'hubot where is everybody'

      it 'should respond that Alice, Bob and Andrew are out', ->
        expect(room.messages).to.include.something.eql ['hubot', "#{expected}"]   

    describe 'grace asks where everybody is', ->    
      beforeEach ->
        room.user.say 'grace', 'hubot WHERE IS EVERYBODY'

      it 'should respond that Alice, Bob and Andrew are out', ->
        expect(room.messages).to.include.something.eql ['hubot', "#{expected}"]      

  describe 'alice, bob and andrew are back', ->
    describe 'grace asks where everybody is', ->
      beforeEach ->
        room.user.say 'bob', 'hubot I am back'
        room.user.say 'alice', 'hubot I am back'
        room.user.say 'andrew', 'hubot I am back'
        room.user.say 'grace', 'hubot where\'s everybody?'

      it 'responds that everybody is in', ->
        expect(room.messages).to.include.something.eql ['hubot', "everybody should be in..."]
