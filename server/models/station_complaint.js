const mongoose = require('mongoose');

const station_complain = new mongoose.Schema({
  Stationname: {
    required: true,
    type: String
  },
  platform_no :{
    required : true,
    type :Number
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
  },
  complaint_registerd :{
    type : Boolean,
    default : false
  },
  complaint_reviewed :{
    type: Boolean,
    default : false
  },
  action_taken :{
    type : Boolean,
    default : false
  },
  complaint_resolved:{
    type : Boolean,
    default : false
  },
});

// Export the Mongoose model
module.exports = mongoose.model('station_complaint', station_complain);
