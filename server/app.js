const express = require('express')
const mongoose = require('mongoose')
const station_complaint_router = require('./routes/station_complaint_router')
const train_complaint_router = require('./routes/train_complaint_router');
const app = express()
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


app.get('/', function (req, res) {
    res.send('hello world');
})

mongoose.connect("mongodb+srv://shubhambera100:shubhambera100@railmadad.t2amj.mongodb.net/?retryWrites=true&w=majority&appName=railMadad").then(() => {
    console.log('connection created');
}).catch((e) => {
    console.log('databse connection error');
});


app.use(station_complaint_router);
app.use(train_complaint_router);

app.listen(3000, () => {
    console.log("port is connected to " + 3000);
})