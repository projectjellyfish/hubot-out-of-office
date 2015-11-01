chai = require 'chai'
Helper = require('hubot-test-helper')
helper = new Helper('./../src/out-of-office.coffee')

expect = chai.expect
chai.use(require('chai-things'))

room = null
describe 'users are sick', ->
  beforeEach ->
    room = helper.createRoom()

  afterEach ->
    room.destroy()

  describe 'alice is sick', ->
    beforeEach ->
      room.user.say 'alice', 'hubot I\'m sick'

    it 'should tell alice to get better', ->
      expect(room.messages).to.include.something.eql ['hubot', '@alice get well soon!']

  describe 'bob is sick', ->
    beforeEach ->
      room.user.say 'bob', 'hubot I am sick'

    it 'should tell bob to get better', ->
      expect(room.messages).to.include.something.eql ['hubot', '@bob get well soon!']  

  describe 'andrew is sick', ->
    beforeEach ->
      room.user.say 'andrew', 'hubot I AM SICK'

    it 'should tell andrew to get better', ->
      expect(room.messages).to.include.something.eql ['hubot', '@andrew get well soon!']  