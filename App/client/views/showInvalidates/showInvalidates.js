/**
 * Created by vimukthi on 2/4/16.
 */
Template.showInvalidates.events({
    "click .validateThisUser": function (event, target) {
        Meteor.call('upgradeToValidated', Meteor.userId(), this._id, function (err, data) {
            console.log(err, data);
        })
        console.log(this.id);
    }
})