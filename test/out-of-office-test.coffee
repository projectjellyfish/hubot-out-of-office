chai = require 'chai'
Helper = require('hubot-test-helper')
helper = new Helper('./../src/out-of-office.coffee')

expect = chai.expect
chai.use(require('chai-things'))

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
      room.user.say 'grace', 'hubot I\'M OUT OF THE OFFICE'

    it 'reponds <user> out of office', ->
      expect(room.messages).to.include.something.eql ['hubot', '@alice out of office']
      expect(room.messages).to.include.something.eql ['hubot', '@bob out of office']
      expect(room.messages).to.include.something.eql ['hubot', '@dave out of office']
      expect(room.messages).to.include.something.eql ['hubot', '@geoff out of office']
      expect(room.messages).to.include.something.eql ['hubot', '@grace out of office']

  context 'user tells hubot they are on holiday', ->
    beforeEach ->
      room.user.say 'alice', 'hubot I\'m on holiday'
      room.user.say 'bob', 'hubot I\'m on vacation'
      room.user.say 'dave', 'hubot I am on holiday'
      room.user.say 'geoff', 'hubot I am on vacation'
      room.user.say 'grace', 'hubot I AM ON VACATION'

    it 'responds <user> on holiday', ->
      expect(room.messages).to.include.something.eql ['hubot', '@alice on holiday']
      expect(room.messages).to.include.something.eql ['hubot', '@bob on holiday']
      expect(room.messages).to.include.something.eql ['hubot', '@dave on holiday']
      expect(room.messages).to.include.something.eql ['hubot', '@geoff on holiday']
      expect(room.messages).to.include.something.eql ['hubot', '@grace on holiday']

  context 'user tells hubot they are back', ->
    beforeEach ->
      room.user.say 'alice', 'hubot I\'m back'
      room.user.say 'bob', 'hubot I am back'
      room.user.say 'dave', 'hubot I AM BACK'

    it 'responds <user> welcome back!', ->
      expect(room.messages).to.include.something.eql ['hubot', '@alice welcome back!']
      expect(room.messages).to.include.something.eql ['hubot', '@bob welcome back!']
      expect(room.messages).to.include.something.eql ['hubot', '@dave welcome back!']

  context 'users asks where everybody is', ->
    beforeEach ->
      room.user.say 'alice', 'hubot where\'s everybody?'
      room.user.say 'bob', 'hubot where is everyone'
      room.user.say 'dave', 'hubot where\'s everyone'
      room.user.say 'geoff', 'hubot where is everybody'
      room.user.say 'grace', 'hubot WHERE IS EVERYBODY'

    it 'responds <user> I don\'t know', ->
      expect(room.messages).to.include.something.eql ['hubot', '@alice I don\'t know']
      expect(room.messages).to.include.something.eql ['hubot', '@bob I don\'t know']
      expect(room.messages).to.include.something.eql ['hubot', '@dave I don\'t know']
      expect(room.messages).to.include.something.eql ['hubot', '@geoff I don\'t know']
      expect(room.messages).to.include.something.eql ['hubot', '@grace I don\'t know']

