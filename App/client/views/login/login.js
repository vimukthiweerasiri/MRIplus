/**
 * Created by vimukthi on 2/4/16.
 */
Template.login.events({
    "click #loginButton": function (event, target) {
        var userEmail = $("#useremail").val();
        var password = $("#userpassword").val();
        console.log(userEmail, password);
        Meteor.loginWithPassword(userEmail, password, function (err, data) {
            console.log(err, data);
            if(err) console.log(err.reason);
            $("#useremail").val('');
            $("#userpassword").val('');
        })
    }
})
