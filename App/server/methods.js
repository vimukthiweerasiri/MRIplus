/**
 * Created by vimukthi on 2/1/16.
 */

var getPredictionAsync = function(base64string, callback) {
    HTTP.call( 'GET', 'http://localhost:5000/'.concat(base64string), {}, function( err, response ) {
        console.log(err, response);
        callback(null, {err: err, response:response.data});
    });
};
var getPrediction = Meteor.wrapAsync(getPredictionAsync);

Meteor.methods({
    predict: function (base64string) {
        console.log()
        return getPrediction(base64string.replace(/\//g, '-')).response;
    },
    addData: function (data1, data2) {
        // TODO: do type checkings here
        CommunityData.insert({'train': data1, 'tatget': data2});
    },
    getToVerify: function () {
        // TODO: make a policy to make the new one
        data = CommunityData.findOne();
        return {'id': data._id, 'train': data.train, 'target': data.target};
    }
});