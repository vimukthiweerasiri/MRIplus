/**
 * Created by vimukthi on 2/3/16.
 */
var verifyingID = 0;

var recordResponse = function (response) {
    $("#verifyingDiv").hide();
    Meteor.call('recordResponse', Meteor.userId(), verifyingID, response, function (err, data) {
        console.log(err, data);
        $("#verifyingDiv").hide();
    })
}


Template.verifyData.events = {
    "click #verify": function (event, target) {
        Meteor.call('getToVerify', function (err, data) {
            verifyingID = data['_id'];
            $("#verifyIm1").attr("src", 'data:image/png;base64,'.concat(data['train']));
            $("#verifyIm2").attr("src", 'data:image/png;base64,'.concat(data['target']));
            $("#verifyingDiv").show();
        })
    },
    "click #correct": function (event, target) {
        recordResponse(1);
    },
    "click #incorrect": function (event, target) {
        recordResponse(-1);
    },
    "click #skip": function (event, target) {
        recordResponse(0);
    }
}

Template.verifyData.onRendered(function () {
    $("#verifyingDiv").hide();
})
