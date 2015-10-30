# Description
#   Keeps track of who is working from home, who is out of the office, and who is on holiday
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   I'm out of the office
#   I'm on holiday
#   I'm back
#   Where is everybody?
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
    users.forEach (user) ->
      status = robot.brain.get("#{user.id}.ooo")
      status = "in" if status == null
      results.push {user: user.id, status: status}

    response = ""
    results.forEach (result) ->
      response += "#{result.user} is #{result.status}\n"

    res.reply "\n#{response}"
