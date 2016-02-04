/**
 * Created by vimukthi on 2/1/16.
 */
Meteor.startup(function() {
    console.log("client started");
    var dicom = "dfasdfsd";
    //Meteor.call('predict', dicom, function(err, data){
    //    console.log(err, data);
    //})
});

Tracker.autorun(function () {
    if(Meteor.userId()){
        Meteor.call('getLevel', Meteor.userId(), function (err, data) {
            Session.set('level', data['level']);
        })
    }
});