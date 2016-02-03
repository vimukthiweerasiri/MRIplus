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

                var original_image = new Image();
                original_image.src = 'data:image/png;base64,'.concat(data['original'])
                document.body.appendChild(original_image);

                var result_image = new Image();
                result_image.src = 'data:image/png;base64,'.concat(data['result'])
                document.body.appendChild(result_image);
                console.log(err, data);
            })
        };

        reader.readAsBinaryString(file);
    }
}