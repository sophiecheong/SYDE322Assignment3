const mysql = require("mysql");

const config = {
    user: 'root',
    password: '',
    host: '127.0.0.1', //root:@127.0.0.1:3306:
    database: 'assignment3'
};

const mysqlConnection = {
    runQuery: function(queryStr, cb) {
        const connection = mysql.createConnection(config);  // connect to your database
        connection.connect();
        connection.query(queryStr, cb); //cb = callback function
    },
    insertQuery: function(queryStr, values, cb) {
        var response;
        const connection = mysql.createConnection(config);  // connect to database
        connection.connect();
        connection.query(queryStr, values, cb); //cb = callback function
    }
};

module.exports = mysqlConnection;