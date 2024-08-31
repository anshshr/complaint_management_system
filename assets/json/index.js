const express=require('express')
const app=express()
const temp=require('./railwayStationsList.json')
const jsonData=temp['stations']
app.get('/',(req,res)=>{
    const jsonFile=[]
    for (const stations of jsonData) {
        jsonFile.push({stnName:stations['stnName']})
    }
    res.send(jsonFile)
})
app.listen(5000,()=>{
    console.log("running")
})