const express = require('express');
const router = express.Router();
const path = require('path');
const mysqlConnection = require('./sqlConnection');

// middleware that is specific to this router
// router.use(function timeLog (req, res, next) {
//   console.log('Time: ', Date.now());
//   next();
// });

// router.get('/', function (req, res) {
// 	res.sendFile(path.join(__dirname + '/../public/index.html'));
// });

router.get('/home', function (req, res) {
	res.render(path.join(__dirname + '/../public/home.html'));
});

router.post('/client', function (req, res) {
	const query = 'INSERT INTO Client (clientName, clientAddress, finesOutstanding) VALUES (?, ?, ?)';
	const values = [ req.body.clientName, req.body.clientAddress, req.body.clientFines ];	
	const results = mysqlConnection.insertQuery(query, values);
	console.log(results);
	res.status(200).json({ success: 'Insert successful' }).end();
});

module.exports = router