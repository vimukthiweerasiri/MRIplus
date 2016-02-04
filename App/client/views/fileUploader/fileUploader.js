/**
 * Created by vimukthi on 2/3/16.
 */
Template.fileUploader.events = {
    "click #predict-btn": function(event){
        $("#predict-btn").toggleClass('active');
        console.log('fasdfsdfsdfasf')
        event.preventDefault();
        event.stopPropagation();
        var file = $(".input-image").prop("files")[0];
        console.log(file);
        var reader = new FileReader();
        reader.onload = function(readerEvt) {
            var binaryString = readerEvt.target.result;
            var str = btoa(binaryString);
            Meteor.call('predict', str, function(err, data){
                console.log(data);
                $("#inIm1").attr("src", 'data:image/png;base64,'.concat(data['original']));
                $("#inIm2").attr("src", 'data:image/png;base64,'.concat(data['result']));
                $("#predict-show").show();
            })
        };
        reader.readAsBinaryString(file);
        return false;
    },
    "click #another": function () {
        $("#predict-show").hide();
        $("#predict-btn").click();

    },
}

Template.fileUploader.rendered = function () {
    $("#predict-show").hide();
}