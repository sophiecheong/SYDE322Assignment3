const express = require('express');
const bodyParser = require("body-parser");
const app = express();
const viewRoutes = require('./server/routes');
const apiRoutes = require('./server/apiRoutes');

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use('/', viewRoutes);
app.use('/api', apiRoutes);

const server = app.listen(8080, function () {
    console.log('Server is running..');
});
