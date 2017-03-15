const express = require('express');
const router = express.Router();
const path = require('path');
const mysqlConnection = require('./sqlConnection');

// middleware that is specific to this router
// router.use(function timeLog (req, res, next) {
//   console.log('Time: ', Date.now());
//   next();
// });

router.post('/client', function (req, res) {
	const query = 'INSERT INTO Client (clientName, clientAddress, finesOutstanding) VALUES (?, ?, ?)';
	const values = [ req.body.clientName, req.body.clientAddress, req.body.clientFines ];	
	const results = mysqlConnection.insertQuery(query, values, function (err, results){
		if (!!err) {
			console.log("query error: ", err);    //Show error in terminal
			res.status(500).json({ error: err }).end();
		}
        res.status(200).json({ success: 'Insert successful' }).end();    // send success as a response
	});
});

router.get('/drones', function (req, res) {
	const query = 'SELECT * FROM Drone ' + getSearchConditions(req.query) + ';';
	mysqlConnection.runQuery(query, function (err, results){
		if (!!err) {
			console.log("query error: ", err);    //Show error in terminal
			res.status(500).json({ error: err }).end();
		}
		res.status(200).json({ data: results }).end();
	});
});

function getSearchConditions(options) {
	if(!Object.keys(options).length) 
		return '';

	var clause = "WHERE";
	for(var option in options) {
		if("WHERE" == clause) 
			clause += " " + option + "='" + options[option] + "'";
		else
			clause += " AND " + option + "='" + options[option] + "'";
	}
	return clause;

}

module.exports = router;