/**
 * Created by vimukthi on 2/4/16.
 */
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