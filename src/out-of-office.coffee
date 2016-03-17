# Description
#   Keeps track of who is working from home, who is out of the office, and who is on holiday
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot I am out of office | ooo <until date> - tell hubot you are out of the office
#   hubot I am on holiday <until date> - tell hubot you are on holiday (e.g. until next Friday)
#   hubot I am working from home | wfh <until date> - tell hubot you are working from home (e.g. until tomorrow)
#   hubot I am traveling | ot <until date> - tell hubot you are on business travel (e.g. until 12/31/16)
#   hubot I am sick <until date> - tell hubot you are sick (e.g. until Monday)
#   hubot I am back - tell hubot you are back
#   hubot Where is everybody? - ask hubot where everybody is
#   hubot Where is @user1? - ask hubot where user1 is
#   hubot it's a new day|reset - resets everyone's status to in for a fresh day of fun
#   hubot HARDRESET - forces reset for all users

# use till / until on to set future date?
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Jason Nichols (jasonnic@gmail.com)  
#      orig - Andrew Braithwaite <andrew.braithwaite@laterooms.com>
#
chrono = require 'chrono-node'
moment = require 'moment'
util = require 'util'
#Fri Mar 18 2016 12:00:00
momentFormat = 'ddd MMM D YYYY [at] HH:mm'

module.exports = (robot) ->
  robot.respond /I(?:\'m| am) (?:ooo|out of (?:the )?office)(?: (?:until|till) (.*$))?/i, (res) ->
    setUntilDate robot, res, "out of office" 

  robot.respond /I(?:\'m| am) on (?:holiday|vacation)(?: (?:until|till) (.*$))?/i, (res) ->
    setUntilDate robot, res, "on holiday" 


  robot.respond /I(?:\'m| am) (?:wfh|working from home)(?: (?:until|till) (.*$))?/i, (res) ->
    setUntilDate robot, res, "working from home"

  robot.respond /I(?:\'m| am) sick(?: (?:until|till) (.*$))?/i, (res) ->
    setUntilDate robot, res, "get well soon!"

  robot.respond /I(\'m| am) back/i, (res) ->
    robot.brain.remove("#{res.message.user.name}.ooo")
    res.reply "welcome back!"
   
  robot.respond /I(?:\'m| am) (?:ot|traveling|on travel)(?: (?:until|till) (.*$))?/i, (res) ->
    setUntilDate robot, res, "on business travel" 
    

  robot.respond /where(\'s| is) @([\w.-]*)\??/i, (res) ->
    username = res.match[2]
    user = robot.brain.userForName username
    return res.reply "who is #{username}?" unless user?

    status = robot.brain.get("#{username.toLowerCase()}.ooo")

    return res.reply "#{user.real_name} should be in..." unless status?
    res.reply "#{user.real_name} is #{status}"

  robot.respond /where(\'s| is) every(one|body)\??/i, (res) ->
    results = []
    for own key, user of robot.brain.data.users
      status = robot.brain.get("#{user.name.toLowerCase()}.ooo")
      if status?
        robot.logger.debug("Status: #{status}")
        untilDate = robot.brain.get("#{user.name.toLowerCase()}.ooo.until")
        if untilDate?
            #robot.logger.debug("status until #{untilDate}") if untilDate?
            results.push {name: user.real_name, status: status, until: moment(untilDate).format(momentFormat)}
        else
            results.push {name: user.real_name, status: status}
    robot.logger.debug("Results: #{util.inspect(results)}")    
    response = results.reduce(((x,y) -> 
        if y.until?
            x + "#{y.name} is #{y.status} until #{y.until}\n"
        else
            x + "#{y.name} is #{y.status}\n"), "")
    robot.logger.debug("Response: #{util.inspect(response)}")
    return res.send 'everybody should be in...' unless !!response
    res.send "#{response}" 

  ##Nightly reset
  robot.respond /(it(\'s| is) a new day|reset|reset status|nightly)/i, (res) ->
    results = []
    for own key, user of robot.brain.data.users
        untilDate = robot.brain.get("#{user.name.toLowerCase()}.ooo.until")

        if untilDate? && moment(untilDate).isAfter(chrono.parseDate("today"))
            robot.logger.debug("Status Until: #{untilDate} not removing status")    

            results.push {name: user.real_name, status: robot.brain.get("#{user.name.toLowerCase()}.ooo"), until: moment(untilDate).format(momentFormat)}
        else
            robot.brain.remove("#{user.name.toLowerCase()}.ooo")
    if results?
        robot.logger.debug("Results: #{util.inspect(results)}")    

        response = results.reduce(((x,y) -> x + "#{y.name} is #{y.status} until #{y.until}\n"), "") 
        robot.logger.debug("Response: #{util.inspect(response)}")

        return res.send "It's a new day!  The team is in except for:\n#{response}"
    else
        return res.send 'It\'s a new day!\nThe entire team is in!'
    
   robot.respond /(HARDRESET)/, (res) ->
    for own key, user of robot.brain.data.users
      robot.brain.remove("#{user.name.toLowerCase()}.ooo")
      robot.brain.remove("#{user.name.toLowerCase()}.ooo.until")

    
    robot.logger.debug("Brain Status: #{util.inspect(robot.brain)}")
    return res.send 'Forced Reset Done, everybody is in!'




setUntilDate = (robot, res, statusMessage) ->
    
    user = res.message.user.name.toLowerCase()
    robot.brain.set("#{user}.ooo", statusMessage)
        
    if res.match[1] is null or res.match[1] is "" or res.match[1] is undefined
        # robot.logger.debug("Brain Full: #{util.inspect(robot.brain)}");
        brain = robot.brain.userForName(user)
        # robot.logger.debug("Brain Status: #{util.inspect(brain)}");
        return res.reply(statusMessage)
    else
        statusEndTime = chrono.parseDate(res.match[1])
        robot.logger.debug("Status Until: #{statusEndTime}")
        if moment(statusEndTime).isBefore(chrono.parseDate("today"))
            robot.logger.debug('Date before today, setting to next date') 
            statusEndTime = chrono.parseDate("next #{res.match[1]}")
            robot.logger.debug("new endTime = #{statusEndTime}")  
        robot.brain.set("#{user}.ooo.until", statusEndTime)
        brain = robot.brain.get("#{user}.ooo.until")
        robot.logger.debug("Brain Status: #{util.inspect(brain)}");
        return res.reply "#{statusMessage} until #{moment(statusEndTime).format(momentFormat)}"

