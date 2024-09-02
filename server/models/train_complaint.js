const mongoose = require('mongoose');  

const train_complaint = new mongoose.Schema({
  Trainname: {
    required: true,
    type: String  
  },
  pnrno: {
    required: true,
    type: Number  
  },
  date: {
    required: true,
    type: String,   
    default: Date.now
  },
  problem_desc: {
    required: true,  
    type: String
  },
  department: {
    required: true,
    type: String,
    trim: true
  },
  media: {
    type: [String],
    required: true
  }
});

// Export the Mongoose model
module.exports = mongoose.model('train_complaint', train_complaint);  