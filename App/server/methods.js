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
        CommunityData.insert({'train': data1, 'target': data2});
    },
    getToVerify: function () {
        // TODO: make a policy to make the new one, get id from responses and fetch here
        var data = CommunityData.findOne();
        console.log({'id': data['_id'], 'train': data['train'], 'target': data['target']});
        return {'id': data['_id'], 'train': data['train'], 'target': data['target']};
    },
    getUnvalidatedUsers: function (userID) {
        console.log(Meteor.users.find({}));
        return Meteor.users.findOne({});
    },
    getValidatedUsers: function (userID) {
        console.log(Meteor.users.find({'level': 1}));
        return Meteor.users.findOne({'level':1});
    },
    recordResponse: function (userID, verifyingID, response) {
        CommunityResponse.insert({'userID': userID, 'verifyingID': verifyingID, 'response': response});
    }
});