/**
 * Created by vimukthi on 2/3/16.
 */
Template.dataUpload.events = {
    "click #upload-data": function (event, target) {
        event.preventDefault();
        var file1 = $(".input1").prop("files")[0];
        var file2 = $(".input2").prop("files")[0];

        var reader1 = new FileReader();
        reader1.onload = function(readerEvt1){
            var binarystr1 = readerEvt1.target.result;
            var data1 = btoa(binarystr1);
            var reader2 = new FileReader();
            reader2.onload = function(readerEvt2){
                var binarystr2 = readerEvt2.target.result;
                var data2 = btoa(binarystr2);
                console.log('submitting 2 files', data1.length, data2.length);
                $("#uploading-div").hide();
                $("#upload-feedback").show();
                Meteor.call('addData', data1, data2, function (err, data) {

                })
            }
            reader2.readAsBinaryString(file2);

        }
        reader1.readAsBinaryString(file1);

        return false;
    }
}

Template.dataUpload.rendered = function () {
    $("#upload-feedback").hide();
}
