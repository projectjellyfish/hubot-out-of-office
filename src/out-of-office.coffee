# Description
#   Keeps track of who is working from home, who is out of the office, and who is on holiday
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Andrew Braithwaite <andrew.braithwaite@laterooms.com>

module.exports = (robot) ->

  robot.respond /(I'm|I am) (ooo|out of (the )?office)/i, (res) ->
    res.reply "out of office"

  robot.respond /(I'm|I am) on (holiday|vacation)/i, (res) ->
    res.reply "on holiday"
