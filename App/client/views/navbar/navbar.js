/**
 * Created by vimukthi on 2/4/16.
 */

Template.navbar.helpers({
    authenticated: function() {
        return Meteor.user() || Meteor.loggingIn();
    },
    isAdmin: function () {
        return Session.get('level') === 2;
    },
    isValidated: function () {
        return Session.get('level') ? Session.get('level') > 0 : false
    }

});

Template.navbar.events({
    "click #logoutUser": function (event, users) {
        Meteor.logout(function (err, data) {
            console.log(err, data);
            $("#navhead").click();
        })
    }
})