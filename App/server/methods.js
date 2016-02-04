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

var getUsers = function (level, callback) {
    Meteor.users.find({level: 0}, {field: {_id: 1, email: 1, phone: 1, website: 1}})
}

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
        return {'id': data['_id'], 'train': data['train'], 'target': data['target']};
    },
    recordResponse: function (userID, verifyingID, response) {
        CommunityResponse.insert({'userID': userID, 'verifyingID': verifyingID, 'response': response});
    },
    upgradeToValidated: function (userID, role) {
        // TODO: check userID here and below
        console.log('this is called', role);
        Meteor.users.update({_id: role}, {$set: {level: 1}});
    },
    upgradeToAdmin: function (userID, role) {
        console.log('this is called', role);
        Meteor.users.update({_id: role}, {$set: {level: 2}});
    },
    getInvalidates: function (userID) {
        return Meteor.users.find({level: 0}, {field: {_id: 1, address: 1, phone: 1, website: 1}}).fetch();
    },
    getValidates: function (userID) {
        return Meteor.users.find({level: 1}, {field: {_id: 1, address: 1, phone: 1, website: 1}}).fetch();
    },
    getLevel: function (userID) {
        return Meteor.users.findOne({_id: userID});
    }
});