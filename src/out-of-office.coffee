# Description
#   Keeps track of who is working from home, who is out of the office, and who is on holiday
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot I am out of office - tell hubot you are out of the office
#   hubot I am on holiday - tell hubot you are on holiday
#   hubot I am working from home - tell hubot you are working from home
#   hubot I am traveling - tell hubot you are on business travel
#   hubot I am sick - tell hubot you are sick
#   hubot I am back - tell hubot you are back
#   hubot Where is everybody? - ask hubot where everybody is
#   hubot Where is @user1? - ask hubot where user1 is
#   hubot reset - resets everyone's status to in
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Andrew Braithwaite <andrew.braithwaite@laterooms.com>

module.exports = (robot) ->

  robot.respond /I(\'m| am) (ooo|out of (the )?office)/i, (res) ->
    robot.brain.set("#{res.message.user.name.toLowerCase()}.ooo", "out of office")
    res.reply "out of office"

  robot.respond /I(\'m| am) on (holiday|vacation)/i, (res) ->
    robot.brain.set("#{res.message.user.name.toLowerCase()}.ooo", "on holiday")
    res.reply "on holiday"

  robot.respond /I(\'m| am) (wfh|working from home)/i, (res) ->
    robot.brain.set("#{res.message.user.name.toLowerCase()}.ooo", "working from home")
    res.reply "working from home"

  robot.respond /I(\'m| am) sick/i, (res) ->
    robot.brain.set("#{res.message.user.name.toLowerCase()}.ooo", "sick")
    res.reply "get well soon!"

  robot.respond /I(\'m| am) back/i, (res) ->
    robot.brain.remove("#{res.message.user.name}.ooo")
    res.reply "welcome back!"
   
  robot.respond /I(\'m| am) (ot|traveling|on travel)/i, (res) ->
    robot.brain.set("#{res.message.user.name.toLowerCase()}.ooo", "on business travel")
    res.reply "on business travel" 
    

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
      results.push {name: user.real_name, status: status} if status?

    response = results.reduce(((x,y) -> x + "#{y.name} is #{y.status}\n"), "")

    return res.send 'everybody should be in...' unless !!response
    res.send "#{response}" 

  robot.respond /(reset|reset status)/i, (res) ->
    results = []
    for own key, user of robot.brain.data.users
      robot.brain.remove("#{user.name}.ooo")
      status = robot.brain.get("#{user.name.toLowerCase()}.ooo")
      results.push {name: user.real_name, status: status} if status?

    response = results.reduce(((x,y) -> x + "#{y.name} is #{y.status}\n"), "")

    return res.send 'everybody should be in...' unless !!response
    res.send "#{response}" 
