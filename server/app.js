const express = require('express');
const mongoose = require('mongoose');
const station_complaint_router = require('./routes/station_complaint_router');
const train_complaint_router = require('./routes/train_complaint_router');
const app = express();

// Use environment variables for MongoDB URI and PORT
const PORT = process.env.PORT || 3000;
const MONGO_URI = process.env.MONGO_URI || 'mongodb+srv://anshshriofficial:MafbZcoXh3WuhtS8@railmadad.t2amj.mongodb.net/?retryWrites=true&w=majority&appName=railMadad';

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    res.send('Welcome to the Complaint Management System');
});

// MongoDB connection
mongoose.connect(MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Connected to MongoDB'))
    .catch((e) => console.error('Database connection error:', e));

// Use the complaint routers
app.use('/api', station_complaint_router);
app.use('/api', train_complaint_router);

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
