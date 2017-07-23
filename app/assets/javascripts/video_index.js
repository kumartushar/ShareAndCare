$(document).ready(function(e) {
	customAutoComplete({
		id: "mytube-search-field",
		url: "/videos/search",
		isSearchForBlank: false
	});

	$(document).on("click", ".mytube-actions .glyphicon-upload", function(e){
		if (isCreateChannel) {
			var channelForm = '<input type="text" name="channel[name]" placeholder="Channel Name"id="channel-name-input-field"><button id="add-channel-button" type="button" class="btn btn-success">Create</button>';
			showSmallModal("Create Channel", channelForm, true);
		} else {
			window.location.href = "/videos/new";
		}
	});

	$(document).on("click", ".mt-lockup-video", function(e) {
		var videoID = $(e.target).closest(".mt-lockup-video").attr("data-context-item-id");
		window.location.href = "/videos/" + videoID;
	});

	$(document).on("click", "#mytube-header .logo", function(e) {
		window.location.href = "/videos";
	});

	$(document).on("click", "#add-channel-button", function(e) {
		var channelName = $("#channel-name-input-field").val();
		var fd = new FormData();
		fd.append("name", channelName);
		sendAjaxWithNoDataProcessing("/channel", fd, "POST");
	})
});