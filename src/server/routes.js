const express = require('express');
const router = express.Router();
const path = require('path');
const fs = require('fs');

// middleware that is specific to this router
// router.use(function timeLog (req, res, next) {
//   console.log('Time: ', Date.now());
//   next();
// });

router.get('/', function (req, res) {
	res.sendFile(path.join(__dirname + '/../public/index.html'));
});

router.get('/partial/header', function (req, res) {
	fs.readFile(path.join(__dirname + '/../public/partial-header.html'), function(err, text){
	   res.writeHead(200, { 'Content-Type': 'text/html' });
	   res.end(text);
	});
})

router.get('/drones', function (req, res) {
	res.sendFile(path.join(__dirname + '/../public/drones.html'));
});

router.get('/register', function (req, res) {
	res.sendFile(path.join(__dirname + '/../public/register.html'));
});

module.exports = router;