express = require 'express'
cookieParser = require 'cookie-parser'
session = require 'express-session'
coffee = require 'connect-coffee-script'
serveStatic = require 'serve-static'
serveFavicon = require 'serve-favicon'
bodyParser = require 'body-parser'
db = require './db'

setupDB = require 'setupDB'
setupDB()

app = express()

#dossier des vues et format
app.set 'views', "#{__dirname}/../views"
app.set 'view engine', 'jade'
, (err, value)->

#favicon
app.use serveFavicon "#{__dirname}/../public/favicon.ico"

#interpret body of request
app.use bodyParser.urlencoded()

#securité de session
app.use cookieParser '31415926535'
app.use session secret:'31415926535'

#compiler les .coffee requis si besoin
app.use coffee
  src: "#{__dirname}/../views/ressources"
  dest: "#{__dirname}/../public/js"

#fichier static (.js, .css,...)
app.use serveStatic "#{__dirname}/../public"

#reponse a '/'
app.get '/', (req,res,next) ->
  res.render 'index', title: 'login'

app.post '/login', (req,res,next) ->
  re = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/
  if re.test req.body.mail
    db.get req.body.mail, (err, value)->
      if err?
        res.json
          logged: 'false'
        username = "-1"
      else
        username = value
  else
    username = req.body.email

  if username != "-1"
    db.users.get username, (err, value) ->
      if err?
        res.json
          logged: 'false'
      else
        if value[password] like req.body.pass
          res.json
            logged: 'true'
            firstName: value[firstName]
            lastName: value[lastName]
        else
          res.json
            logged: 'false'

module.exports = app
