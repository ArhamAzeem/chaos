const express = require('express')
                                                                                      
const app = express()                                                                 
                                                                                      
app.get('/health',(req,res)=>{                                                                  res.status(200).json({
                health: 1                                                                     })                                                                            
})

app.listen(3000,()=>console.log('Running on port 3000'))
