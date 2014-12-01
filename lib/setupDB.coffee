db = require 'db'

module.export ()->
  user = {}
    user.firstName = "Clement"
    user.lastName = "Camboulives"
    user.password = "a"
    user.userName = "cambouli"
  db.users.set 'cambouli', user, (err)->
  db.email.set 'cambouli', 'cambouli@ece.fr', (err)->

  user = {}
    user.firstName = "Larry"
    user.lastName = "Ndanga"
    user.password = "a"
    user.userName = "larry"
  db.users.set 'larry', user
  db.email.set 'larry', 'larry@ece.fr', (err)->
