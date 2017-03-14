const express = require('express');
const router = express.Router();
const path = require('path');

// middleware that is specific to this router
// router.use(function timeLog (req, res, next) {
//   console.log('Time: ', Date.now());
//   next();
// });

router.get('/', function (req, res) {
	res.sendFile(path.join(__dirname + '/../public/index.html'));
});

router.get('/home', function (req, res) {
	res.render(path.join(__dirname + '/../public/home.html'));
});

router.get('/register', function (req, res) {
	res.sendFile(path.join(__dirname + '/../public/register.html'));
});

module.exports = router