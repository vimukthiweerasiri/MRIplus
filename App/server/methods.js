/**
 * Created by vimukthi on 2/1/16.
 */

var getPredictionAsync = function(base64string, callback) {
    HTTP.call( 'GET', 'http://localhost:5000/'.concat(base64string), {}, function( err, response ) {
        console.log(err, response);
        callback(null, {err: err, response:response.data});
    });
};
var getPrediction = Meteor.wrapAsync(getPredictionAsync);

Meteor.methods({
    predict: function (base64string) {
        console.log()
        return getPrediction(base64string.replace(/\//g, '-')).response;
    }
});