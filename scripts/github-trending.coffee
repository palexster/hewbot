# Description:
#   Gets the latest trending repositories on GitHub.
#
# Dependencies:
#   cheerio
#   request
#
# Configuration:
#   None
#
# Commands:
#   hubot trending - Lists trending repositories (all languages).
#   hubot trending-[language] - Lists trending repositories for the given language.
#   hubot trending [project] - Gets general information for the given project.
#
# Author:
#   Sabri Eddir

cheerio = require 'cheerio'
request = require 'request'

extractRepositories = (error, response, body, msg) ->
  if not error and response.statusCode is 200
    $ = cheerio.load(body)

    results = []

    $('h3').each (i, elem) ->
      link = $(this).children('a').attr("href")
      results.push link.substring(1)

    msg.send results.join ', '

module.exports = (robot) ->

  robot.respond /trending$/i, (msg) ->
    request 'https://github.com/trending', (error, response, body) ->
      extractRepositories(error, response, body, msg)

  robot.respond /trending-(.*)$/i, (msg) ->
    language = msg.match[1]
    request 'https://github.com/trending/'+language, (error, response, body) ->
      extractRepositories(error, response, body, msg)

  robot.respond /trending (.*)$/i, (msg) ->
    project = msg.match[1]
    request 'https://github.com/'+project, (error, response, body) ->
      if not error and response.statusCode is 200
        $ = cheerio.load(body)

        msg.send $('.repository-meta-content').text().trim()
