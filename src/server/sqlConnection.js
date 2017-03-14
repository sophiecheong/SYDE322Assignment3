const mysql = require("mysql");

const config = {
    user: 'root',
    password: '',
    host: '127.0.0.1', //root:@127.0.0.1:3306:
    database: 'assignment3'
};

const mysqlConnection = {
    runQuery: function(queryStr) {
        const connection = mysql.createConnection(config);  // connect to your database
        connection.connect();
        connection.query(queryStr, function (error, results) {
            if (!!error) { 
                console.log("query error: ", error);    //Show error in terminal
                return error;
            }
            return results;    // send results as a response
        });
    },
    insertQuery: function(queryStr, values) {
        var response;
        const connection = mysql.createConnection(config);  // connect to database
        connection.connect();
        connection.query(queryStr, values, function (error, results) {
            if (!!error) { 
                console.log("query error: ", error);    //Show error in terminal
                response = error;
            }
            response = 'success';    // send success as a response
        });
        return response;
    }
};

module.exports = mysqlConnection;