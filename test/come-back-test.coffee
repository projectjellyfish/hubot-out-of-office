chai = require 'chai'
Helper = require('hubot-test-helper')
helper = new Helper('./../src/out-of-office.coffee')

expect = chai.expect
chai.use(require('chai-things'))

room = null
describe 'users come back', ->
  beforeEach ->
    room = helper.createRoom()
    room.user.say 'alice', 'hubot I\'m on holiday'
    room.user.say 'bob', 'hubot I\'m out of office'
    room.user.say 'andrew', 'hubot I\'m out of office'

  afterEach ->
    room.destroy()

  describe 'alice comes back', ->
    beforeEach ->
      room.user.say 'alice', 'hubot I\'m back'

    it 'should welcome alice back', ->
      expect(room.messages).to.include.something.eql ['hubot', '@alice welcome back!']

  describe 'bob comes back', ->
    beforeEach ->
      room.user.say 'bob', 'hubot I am back'

    it 'should welcome bob back', ->
      expect(room.messages).to.include.something.eql ['hubot', '@bob welcome back!']  

  describe 'andrew comes back', ->
    beforeEach ->
      room.user.say 'andrew', 'hubot I AM BACK'

    it 'should welcome andrew back', ->
      expect(room.messages).to.include.something.eql ['hubot', '@andrew welcome back!']  