/**
 * Created by vimukthi on 2/4/16.
 */
var getLevelAsync = function (userID, callback) {
    Meteor.call('getLevel', Meteor.userId(), function (err, data) {
        //console.log(data);
        //console.log(data["level"]);
        callback(null, data);
    })
}

var getLevel = Meteor.wrapAsync(getLevelAsync);


Router.configure({
    layoutTemplate: 'layout',
    notFoundTemplate: 'pageNotFound'
});

Router.route('/', {
    template: 'fileUploader'
})

Router.route('/dataUpload')
Router.route('/fileUploader')
Router.route('/signup')
Router.route('/manageAccounts')
Router.route('/verifyData')
Router.route('/login')


Router.route('/abc', function () {
    console.log('vimukthi is the best');
})