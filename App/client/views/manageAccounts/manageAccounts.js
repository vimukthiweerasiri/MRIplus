/**
 * Created by vimukthi on 2/4/16.
 */
Template.manageAccounts.events({
    "click #validate_user": function (event, target) {
        console.log('validate_user');
        Meteor.call('getUnvalidatedUsers', Meteor.userId(), function (err, data) {
            console.log(err, data);
        })
    },
    "click #create_admin": function (event, target) {
        console.log('admin');
        Meteor.call('getValidatedUsers', Meteor.userId(), function (err, data) {
            console.log(err, data);
        })
    }
})