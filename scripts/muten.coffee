# Description:
#   Encourages users to take an IRC bouncer.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot [user] does not have a bouncer - Saves [user] in memory
#   hubot who does not have a bouncer? - List users without a bouncer from memory
#   hubot [user] (now)? has a bouncer - Remove [user] from memory
#
# Author:
#   Paul Chaignon <paul.chaignon@gmail.com>

String::startsWith ?= (s) -> @slice(0, s.length) == s


_randomNum: (max,min=0) ->
    return Math.floor(Math.random() * (max - min) + min)
    # min is set to 0 by default but a different value can be passed to function


module.exports = (robot) ->
  robot.respond /question!$/, (res) ->
     questions = robot.brain.get('questions') or []
     user_text = users[@_randomNum(10)]
     res.reply user_text 


