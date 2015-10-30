chai = require 'chai'
Helper = require('hubot-test-helper')
helper = new Helper('./../src/out-of-office.coffee')

expect = chai.expect

room = null
describe 'out-of-office', ->
  beforeEach ->
    room = helper.createRoom()

  afterEach ->
    room.destroy()

  context 'user tells hubot they are out of office', ->
    beforeEach ->
      room.user.say 'alice', 'hubot I\'m ooo'
      room.user.say 'bob', 'hubot I\'m out of office'
      room.user.say 'dave', 'hubot I am out of office'
      room.user.say 'geoff', 'hubot I\'m out of the office'

    it 'reponds <user> out of office', ->
      expect(room.messages).to.eql [
        ['alice', 'hubot I\'m ooo']
        ['bob', 'hubot I\'m out of office']
        ['dave', 'hubot I am out of office']
        ['geoff', 'hubot I\'m out of the office']
        ['hubot', '@alice out of office']
        ['hubot', '@bob out of office']
        ['hubot', '@dave out of office']
        ['hubot', '@geoff out of office']
      ]
