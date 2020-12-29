const mongoose = require('mongoose');

const EthAccountSchema = new mongoose.Schema(
    {
        address: {
            type: String,
            unique: true,
            required: true
        },
        privateKey: {
            type: String,
            unique: true,
            required: true
        },
    },
    {strict: false}
)

module.exports = EthAccount = mongoose.model("ethAccount", EthAccountSchema);