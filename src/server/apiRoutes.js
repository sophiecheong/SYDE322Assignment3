const express = require('express');
const router = express.Router();
const path = require('path');
const mysqlConnection = require('./sqlConnection');

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
	var options = "";
	if(!!req.query.startDate) 
		options += "(b.dateDue<'"+req.query.startDate+"' OR b.dateDue IS NULL) AND (m.endDate<'"+req.query.startDate+"' OR m.endDate IS NULL)";
	if(!!req.query.endDate) {
		if(!!options) options += " AND ";
		options += "(b.dateTaken>'" + req.query.endDate + "' OR b.dateTaken IS NULL) AND (m.startDate>'" + req.query.endDate + "' OR m.startDate IS NULL)";
	}
	if(!!req.query.droneType) {
		if(!!options) options += " AND ";
		options += "Drone.droneType='" + req.query.droneType + "'";
	}
	if(!!req.query.manufacturer){
		if(!!options) options += " AND ";
		options += "Drone.manufacturer='" + req.query.manufacturer + "'";
	}
	if(!!req.query.range){
		if(!!options) options += " AND ";
		options += "Drone.range='" + req.query.range + "'";
	}
	const query = 'SELECT Drone.* FROM Drone ' +
					'LEFT JOIN Booking AS b ON Drone.droneID = b.droneID ' +
					'LEFT JOIN MaintenanceRecord as m ON Drone.droneID = m.droneID' + 
					(!!options ? " WHERE " + options : "");

	mysqlConnection.runQuery(query, function (err, results){
		if (!!err) {
			console.log("query error: ", err);    //Show error in terminal
			res.status(500).json({ error: err }).end();
		}
		res.status(200).json({ data: results.map(item => { 
				item.available = !!item.available; 
				return item })
		}).end();
	});
});

function getSearchConditions(options) {
	if(!Object.keys(options).length) return '';

	var clause = "";

	for(var option in options) {
		if(!clause) clause += " " + option + "='" + options[option] + "'";
		else clause += " AND " + option + "='" + options[option] + "'";
	}
	return !!clause? "WHERE" + clause : '' ;
}

module.exports = router;