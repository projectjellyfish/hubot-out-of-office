chai = require 'chai'
Helper = require('hubot-test-helper')
helper = new Helper('./../src/out-of-office.coffee')

expect = chai.expect
chai.use(require('chai-things'))

room = null
expected = "Wally Jones is on holiday"

context 'where\'s wally', ->
  beforeEach ->
    room = helper.createRoom()
    room.robot.brain.data.users = [
      {
        name: "wally"
        real_name: "Wally Jones"
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

  afterEach ->
    room.destroy()

  describe 'wally is on holiday', ->
    beforeEach ->
      room.user.say 'wally', 'hubot I\'m on holiday'

    describe 'andrew asks where wally is', ->
      beforeEach ->
        room.user.say 'andrew', 'hubot where\'s @wally?'

      it 'should respond that Wally is on holiday', ->
        expect(room.messages).to.include.something.eql ['hubot', "@andrew #{expected}"]

    describe 'bob asks where wally is', ->
      beforeEach ->
        room.user.say 'bob', 'hubot where is @wally?'

      it 'should respond that Wally is on holiday', ->
        expect(room.messages).to.include.something.eql ['hubot', "@bob #{expected}"]

    describe 'grace asks where wally is', ->    
      beforeEach ->
        room.user.say 'grace', 'hubot WHERE IS @WALLY'

      it 'should respond that Wally is on holiday', ->
        expect(room.messages).to.include.something.eql ['hubot', "@grace #{expected}"]

    describe 'grace asks where bob is', ->    
      beforeEach ->
        room.user.say 'grace', 'hubot WHERE IS @BOB'

      it 'should respond that Bob should be in', ->
        expect(room.messages).to.include.something.eql ['hubot', "@grace Bob Jones should be in..."] 


    describe 'grace asks where roger is', ->    
      beforeEach ->
        room.user.say 'grace', 'hubot where is @roger'

      it 'should respond that he doesn\`t know who roger is', ->
        expect(room.messages).to.include.something.eql ['hubot', "@grace who is roger?"] 