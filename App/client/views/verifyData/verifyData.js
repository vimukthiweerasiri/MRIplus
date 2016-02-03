/**
 * Created by vimukthi on 2/3/16.
 */
Template.verifyData.events = {
    "click #verify": function (event, target) {
        Meteor.call('getToVerify', function (err, data) {
            console.log(err, data);
        })
    }
}