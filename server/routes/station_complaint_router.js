const mongoose = require('mongoose');
const express = require('express');
const station_complaint = require('../models/station_complaint');
const station_complaint_router = express.Router();

//post a complaint of the station
station_complaint_router.post('/api/station_complaint', async function(req,res){
    try {
        const {Stationname,platform_no,date,problem_desc,department,media} = req.body;
        const new_station_complaint = new station_complaint({
            Stationname,
            platform_no,
             date,
             problem_desc,
            department,
             media
        });
        await new_station_complaint.save();
        return res.status(200).json(new_station_complaint);
    } catch (error) {
        res.status(500).json({
            'error' : error.message,
            'msg' : 'something error occured while registering the station complaint'
        })
    }
})

//to get the atation complaint by departname
station_complaint_router.get('/api/get_station_complaint/:departname', async function(req,res){
    try {
        const complaint_by_departname = await station_complaint.find({department : req.params.departname});
        res.status(200).json(complaint_by_departname);
    } catch (error) {
        res.status(500).json({
            'error' : error.message,
            'msg' : 'something error occured while fetching the station complaint by department name'
        })
    }
})

module.exports = station_complaint_router;