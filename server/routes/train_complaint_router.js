const express = require('express');
const train_complaint = require('../models/train_complaint');
const e = require('express');
const train_complaint_router = express.Router();
//post a complaint
train_complaint_router.post('/api/train_complaint' , async function(req,res){
    try {
        const {Trainname,pnrno,date,problem_desc,department,media} = req.body;
         const new_triain_complaint = new train_complaint({
            Trainname,
            pnrno,
            date,
            problem_desc,
            department,
            media 
         });

         await new_triain_complaint.save();
         console.log('succesfully train complaint registered');
         return res.status(200).json(new_triain_complaint);

    } catch (error) {
        res.status(500).json({
            'error' : error.message,
            'msg' : 'something error occured while registering the train complaint'
        })
    }
})

//get a complaint by pr no.

train_complaint_router.get('/api/get_train_complaint/:pnrno' , async function(req,res){
 try {
    const complaint_by_pnrno  = await train_complaint.find({pnrno : req.params.pnrno});
    if( complaint_by_pnrno.length == 0){
        return res.status(404).json({
            'msg' : 'no complaint found for this pnr no'
        })}
        else{
            return res.status(200).json(complaint_by_pnrno);
        }
 } catch (error) {
    res.status(500).json({
        'error' : error.message,
        'msg' : 'something error occured while fetching the train complaint by pr no'
    })
 }
})

//get a complaint by departname

train_complaint_router.get('/api/get_train_complaint_by_dept/:departname' , async function(req,res){
    try {
        const complaint_by_departname  = await train_complaint.find({department : req.params.departname});

        if( complaint_by_departname.length == 0){
            return res.status(404).json({
                'msg' : 'no complaint found for this department'
            })}
            else{
                return res.status(200).json(complaint_by_departname);
            }
    } catch (error) {
        res.status(500).json({
            'error' : error.message,
            'msg' : 'something error occured while fetching the train complaint by department name'
        })
    }
})

module.exports = train_complaint_router;