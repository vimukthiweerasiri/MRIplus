/**
 * Created by vimukthi on 2/4/16.
 */
Router.configure({
    layoutTemplate: 'layout'
});

Router.route('/', {
    template: 'fileUploader'
})

Router.route('/dataUpload')
Router.route('/fileUploader')
Router.route('/login')
Router.route('/manageAccounts')
Router.route('/verifyData')