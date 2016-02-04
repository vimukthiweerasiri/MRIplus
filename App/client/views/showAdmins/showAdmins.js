/**
 * Created by vimukthi on 2/4/16.
 */
Template.showAdmins.events({
    "click .makeAnAdmin": function (event, target) {
        Meteor.call('upgradeToAdmin', Meteor.userId(), this._id, function (err, data) {
            console.log(err, data);
        })
        console.log(this.id);
    }
})