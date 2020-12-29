const mongoose = require('mongoose');

const TransactionSchema = new mongoose.Schema(
    {
        uid: {
            type: String,
            required: false,
            unique: false
        },
        incoming: Boolean, // If receiving, this is true, if sending, this is false
        user: String,
        counterparty: String, // Other person
        date: String, 
        amount: Number //amount in wei
    },
    {strict: false}
)

module.exports = UserCourse = mongoose.model("transaction", TransactionSchema);