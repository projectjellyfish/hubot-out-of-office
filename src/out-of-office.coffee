# Description
#   Keeps track of who is working from home, who is out of the office, and who is on holiday
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot I am out of office
#   hubot I am on holiday
#   hubot I am back
#   hubot Where is everybody?
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

  robot.respond /I(\'m| am) back/i, (res) ->
    robot.brain.remove("#{res.message.user.name}.ooo")
    res.reply "welcome back!"

  robot.respond /where(\'s| is) every(one|body)\??/i, (res) ->
    results = []
    for own key, user of robot.brain.data.users
      status = robot.brain.get("#{user.name}.ooo")
      results.push {name: user.real_name, status: status} if status != null

    response = ""
    i = 0
    while i < results.length
      response += "#{results[i].name} is #{results[i].status}\n"
      i++

    i

    if response.length == 0
      res.send 'everybody should be in...'
    else
      res.send "\n#{response}"
