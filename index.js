var express = require('express');
var app = express();
var jade = require('jade');

var html = jade.render('p yolo');

app.get('/', function(req, res){
  res.send(html);
});

app.listen(3000);

/*
doctype html
html(lang="fr")
  head
    title= Hello World
  body
    h1 Hello World
    #test.yolo
      p.
        Jade c\'est vraiment tout moche a utiliser...
*/
