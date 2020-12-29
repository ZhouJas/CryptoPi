const mongoose = require('mongoose');
const EthAccount = require('./EthAccount');
const Transaction = require('./Transaction');

const UserSchema = new mongoose.Schema(
    {
        username: {
            type: String,
            required: true,
            unique: true
        },
        piTag: { //use this code after pi integration
            type: String,
            required: false
        },
        ethAccount: {
            type: EthAccount.schema,
            unique: true,
            required: true
        },
        password: {
            type: String,
            required: true,
        },
        azureId: {
            type: String,
            required: false
        },
        transactions: {
            type: [Transaction.schema],
            unique: false,
            default: []
        },
        recentContacts: {
            type: [String],
            required: false,
            unique: false,
            default: []
        },
        balance: {
            type: String,
            required: true,
            unique: false,
            default: 0
        },
    },
    { strict: false }
)

module.exports = User = mongoose.model("users", UserSchema);