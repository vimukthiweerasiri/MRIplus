/**
 * Created by vimukthi on 2/1/16.
 */
Meteor.startup(function(){
    if(!Meteor.users.findOne()){
        var status = Accounts.createUser({
            email: "vimukthiweerasiri@gmail.com",
            profile: {
                name: 'vimukthi'}
        })

        console.log(status, 'userID')
        console.log(Meteor.users.findOne())
    }

});