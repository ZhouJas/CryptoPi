'use strict';

const axios = require('axios').default;

// Add a valid subscription key and endpoint to your environment variables.
let subscriptionKey = 'key'
let endpoint = 'endpoint'

// Optionally, replace with your own image URL (for example a .jpg or .png URL).
let imageUrl = 'https://raw.githubusercontent.com/PhilbertLou/cryptopipi/main/IMG_2877.JPG?token=AP3TC5VS2X2VEBQWSJSGJFC7YG22A'

// Send a POST request
axios({
    method: 'post',
    url: endpoint,
    params : {
        detectionModel: 'detection_02',
        returnFaceId: true
    },
    data: {
        url: imageUrl,
    },
    headers: { 'Ocp-Apim-Subscription-Key': subscriptionKey }
}).then(function (response) {
    console.log('Status text: ' + response.status)
    console.log('Status text: ' + response.statusText)
    console.log()
    console.log(response.data)
}).catch(function (error) {
    console.log(error)
});