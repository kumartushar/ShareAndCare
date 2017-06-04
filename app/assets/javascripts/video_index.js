$(document).ready(function(e) {
	$(document).on("click", ".mytube-actions .glyphicon-upload", function(e){
		window.location.href = "/videos/new";
	});

	$(document).on("click", ".video_block", function(e) {
		var videoID = $(e.target).closest(".video_block").attr("item-id");
		window.location.href = "/videos/" + videoID;
	});
});