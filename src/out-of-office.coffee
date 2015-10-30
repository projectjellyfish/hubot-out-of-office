# Description
#   Keeps track of who is working from home, who is out of the office, and who is on holiday
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot I'm out of the office
#   hubot I'm on holiday
#   hubot I'm back
#   hubot Where is everybody?
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Andrew Braithwaite <andrew.braithwaite@laterooms.com>

module.exports = (robot) ->

  robot.respond /I('m| am) (ooo|out of (the )?office)/i, (res) ->
    robot.brain.set("#{res.message.user.name}.ooo", "out of office")
    res.reply "out of office"

  robot.respond /I('m| am) on (holiday|vacation)/i, (res) ->
    robot.brain.set("#{res.message.user.name}.ooo", "on holiday")
    res.reply "on holiday"

  robot.respond /I('m| am) back/i, (res) ->
    robot.brain.remove("#{res.message.user.name}.ooo")
    res.reply "welcome back!"

  robot.respond /where('s| is) every(one|body)\??/i, (res) ->
    users = robot.brain.users()
    users = [{id: "alice"}, {id: "bob"}, {id: "andrew"}] if Object.keys(users).length == 0

    results = []
    i = 0
    while i < users.length
      status = robot.brain.get("#{users[i].id}.ooo")
      status = "in" if status == null
      results.push {user: users[i].id, status: status}
      i++

    response = ""
    i = 0
    while i < results.length
      response += "#{results[i].user} is #{results[i].status}\n"
      i++

    res.reply "\n#{response}"
