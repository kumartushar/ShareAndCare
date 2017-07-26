$(document).ready(function(e) {

	setLikeDislikeActive(preSentimentAction);

	$(document).on("click", ".mt-sentiment-action", function(e) {
		var targetField = $(e.target).closest(".mt-sentiment-action");
		var action = getSentimentAction($(targetField).attr("mt-post-action"));
		var formData = new FormData();
		formData.append("mt_action", action);
		formData.append("like_dislike_status", preSentimentAction);
		var url = "/videos/" + $(targetField).attr("mt-post-data") + "/like_dislike";
		sendAjaxWithNoDataProcessing(url, formData, "POST");
	});
});

function setLikeDislikeActive(status) {
	switch(status) {
		case "like":
			$("[mt-post-action='like']").addClass("sentiment-active");
			break;
		case "dislike":
			$("[mt-post-action='dislike']").addClass("sentiment-active");
			break;
	}
}

function getSentimentAction(currentAction) {
	var action;
	if (preSentimentAction == "neutral") {
		//0 - add like, 1 - add dislike
		action = currentAction == "like" ? 0 : 1;
		preSentimentAction = currentAction;
	} else if (preSentimentAction == "like") {
		if (currentAction == "like") {
			action = 2; //neutral by removing like
			preSentimentAction = "neutral";
		} else {
			action = 3; //add dislike by removing like
			preSentimentAction = "dislike";
		}
	} else if(preSentimentAction == "dislike") {
		if (currentAction == "like") {
			action = 4; //add like by removing dislike
			preSentimentAction = "like";
		} else {
			action = 5; //neutral by removing dislike
			preSentimentAction = "neutral";
		}
	}
	return action;
}

function update_like_dislike_count(like_count, dislike_count) {
	$("#mt-video-like-count").html(like_count);
	$("#mt-video-dislike-count").html(dislike_count);
}

function update_like_dislike_icons(likeDislikeStatus) {
	$(".mt-sentiment-action").removeClass("sentiment-active");
	setLikeDislikeActive(likeDislikeStatus);
}