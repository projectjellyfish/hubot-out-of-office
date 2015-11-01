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
#   hubot I am back - tell hubot you are back
#   hubot Where is everybody? - ask hubot where everybody is
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Andrew Braithwaite <andrew.braithwaite@laterooms.com>

module.exports = (robot) ->

  robot.respond /I(\'m| am) (ooo|out of (the )?office)/i, (res) ->
    robot.brain.set("#{res.message.user.name}.ooo", "out of office")
    res.reply "out of office"

  robot.respond /I(\'m| am) on (holiday|vacation)/i, (res) ->
    robot.brain.set("#{res.message.user.name}.ooo", "on holiday")
    res.reply "on holiday"

  robot.respond /I(\'m| am) (wfh|working from home)/i, (res) ->
    robot.brain.set("#{res.message.user.name}.ooo", "working from home")
    res.reply "working from home"

  robot.respond /I(\'m| am) sick/i, (res) ->
    robot.brain.set("#{res.message.user.name}.ooo", "sick")
    res.reply "get well soon!"

  robot.respond /I(\'m| am) back/i, (res) ->
    robot.brain.remove("#{res.message.user.name}.ooo")
    res.reply "welcome back!"

  robot.respond /where(\'s| is) every(one|body)\??/i, (res) ->
    results = []
    for own key, user of robot.brain.data.users
      status = robot.brain.get("#{user.name}.ooo")
      results.push {name: user.real_name, status: status} if status != null

    response = results.reduce(((x,y) -> x + "#{y.name} is #{y.status}\n"), "")

    if response.length == 0
      res.send 'everybody should be in...'
    else
      res.send "#{response}"
