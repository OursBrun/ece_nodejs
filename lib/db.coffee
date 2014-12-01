
levelup = require 'levelup'
db = levelup "#{__dirname}../DB"

module.exports =
  users:
    get: (username, callback) ->
      #use db.createReadStream
      #convention sur callback : premier argument une erreur s'il y en a une, deuxieme argument les données.
      user = {}
      db.createReadStream(
        [gt: "users:#{username}:",
        limit: 3 #password, firstname, lastname
        ])
      .on 'data', (data) ->
        [_, username, key] = data.key.split ':'
        user.username ?= username
        user[key] = data.value
      .on 'error', (err) ->
        callback err
      .on 'end', ->
        callback null, user

    set: (username, user, callback) ->
#      user = JSON.stringify user
#      db.put username,user,(err) ->
#        callback err

      ops = []
      for k, v of user
        continue if k is 'userName'
        ops.push
          type: 'put',
          key:"users:#{username}:#{k}",
          value: v
        db.batch ops, (err) ->
          callback err

    del: (user_id, callback) ->
      # TODO

  email:
    get: (email, callback)->
      db.get 'email:#{email}', callback
    set: (username, email, callback) ->
      db.put 'email:#{email}', username, callback
    del: (email, callback)->
      # TODO
