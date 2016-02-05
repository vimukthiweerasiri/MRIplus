/**
 * Created by vimukthi on 2/3/16.
 */
Template.signup.events({
    "click #signup": function (event, target) {
        var email = $("#email").val();
        var password = $("#password").val();
        var mobile = $("#mobile").val();
        var website = $("#website").val();
        console.log(email, password, mobile, website);
        Accounts.createUser({
            email: email,
            password: password,
            mobile: mobile,
            website: website,
            address: email
        }, function (err, data) {
            if(err){
                $("#signuperr").text(err['reason']);
            } else{
                $("#navhead").click();
            }
        });
    }
})