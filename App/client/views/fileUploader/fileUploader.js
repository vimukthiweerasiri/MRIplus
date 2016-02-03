/**
 * Created by vimukthi on 2/3/16.
 */
Template.fileUploader.events = {
    "change .input": function(event){
        var file = event.target.files[0];
        console.log(file);
        var reader = new FileReader();
        reader.onload = function(readerEvt) {
            var binaryString = readerEvt.target.result;
            var str = btoa(binaryString);
            Meteor.call('predict', str, function(err, data){
                console.log(err, data);
            })
        };

        reader.readAsBinaryString(file);
    }
}