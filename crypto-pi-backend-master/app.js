const express = require('express')
var cors = require('cors')
const mongoose = require('mongoose')
const Web3 = require('web3')

mongoose.plugin(schema => { schema.options.usePushEach = true });

const transactions = require('./routes/TransactionRoutes')
const userDetails = require('./routes/UserDetailsRoutes')

const app = express()
const port = 8080 // http://localhost:8080/
const environment = 'development'
const MONGO_URI = 'mongodb://localhost/cryptopi'
//const web3 = new Web3('http://localhost:8080');

mongoose
    .connect(MONGO_URI, {useNewUrlParser: true, useUnifiedTopology: true})
    .then(console.log(`MongoDB connected ${MONGO_URI}`))
    .catch(err => console.log(err))

app.use(cors())
app.use(express.json())
app.use(express.urlencoded({extended: false}))

app.use('/transactions', transactions)
app.use('/userDetails', userDetails)

app.get('/', (req, res) => res.send('CryptoPi API'))

app.listen(port, () => console.log(
  `CryptoPi (${environment}) listening on ${port}!`)
)