$(document).ready(function(e) {
	customAutoComplete({
		id: "mytube-search-field",
		url: "/videos/search",
		isSearchForBlank: false
	});

	$(document).on("click", ".mytube-actions .glyphicon-upload", function(e){
		window.location.href = "/videos/new";
	});

	$(document).on("click", ".mt-lockup-video", function(e) {
		var videoID = $(e.target).closest(".mt-lockup-video").attr("data-context-item-id");
		window.location.href = "/videos/" + videoID;
	});

	$(document).on("click", "#mytube-header .logo", function(e) {
		window.location.href = "/videos";
	});
});