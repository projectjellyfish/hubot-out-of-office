chai = require 'chai'
chrono = require('chrono-node')

Helper = require('hubot-test-helper')
helper = new Helper('./../src/out-of-office.coffee')
moment = require 'moment'
momentFormat = 'ddd MMM D YYYY [at] HH:mm'


expect = chai.expect
chai.use(require('chai-things'))

room = null
describe 'users go out of office', ->
  beforeEach ->
    room = helper.createRoom()

  afterEach ->
    room.destroy()

  describe 'alice goes out of office', ->
    beforeEach ->
      room.user.say 'alice', 'hubot I\'m ooo'

    it 'responds that alice is out of of office', ->
      expect(room.messages).to.include.something.eql ['hubot', '@alice out of office']   
  
  describe 'alice goes out of office for a period of time', ->
    beforeEach ->
      room.user.say 'alice', 'hubot I\'m ooo until next Wednesday'
    it "responds that alice is out of of office until #{moment(chrono.parseDate("next Wednesday")).format(momentFormat)}", ->
      expect(room.messages).to.include.something.eql ['hubot', "@alice out of office until #{moment(chrono.parseDate("next Wednesday")).format(momentFormat)}"]   
 
  describe 'bob goes out of office', ->
    beforeEach ->
      room.user.say 'bob', 'hubot I\'m out of office'

    it 'responds that bob is out of of office', ->
      expect(room.messages).to.include.something.eql ['hubot', '@bob out of office']       

  describe 'dave goes out of office', ->
    beforeEach ->
      room.user.say 'dave', 'hubot I am out of office'

    it 'responds that dave is out of of office', ->
      expect(room.messages).to.include.something.eql ['hubot', '@dave out of office']  

  describe 'geoff goes out of office', ->
    beforeEach ->
      room.user.say 'geoff', 'hubot I\'m out of the office'

    it 'responds that geoff is out of of office', ->
      expect(room.messages).to.include.something.eql ['hubot', '@geoff out of office']  

  describe 'grace goes out of office', ->
    beforeEach ->
      room.user.say 'grace', 'hubot I\'M OUT OF THE OFFICE'

    it 'responds that grace is out of of office', ->
      expect(room.messages).to.include.something.eql ['hubot', '@grace out of office']  
