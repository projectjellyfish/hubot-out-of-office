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
    res.reply "out of office"

  robot.respond /I('m| am) on (holiday|vacation)/i, (res) ->
    res.reply "on holiday"

  robot.respond /I('m| am) back/i, (res) ->
    res.reply "welcome back!"

  robot.respond /where('s| is) every(one|body)\??/i, (res) ->
    res.reply "I don't know"
