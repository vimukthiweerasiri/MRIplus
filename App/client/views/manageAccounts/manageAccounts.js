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

Template.manageAccounts.helpers({
    validates: function () {
        console.log("this works");
        Meteor.call('getInvalidates', Meteor.userId(), function (err, data) {
            console.log(err, data);
            Session.set('getInvalidates', data);
        });
        return Session.get('getInvalidates');
    },
    admins: function () {
        console.log("this worksAAAAA");
        Meteor.call('getValidates', Meteor.userId(), function (err, data) {
            console.log(err, data);
            Session.set('getValidates', data)
        });
        return Session.get('getValidates');
    }
})