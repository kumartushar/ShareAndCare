$(document).ready(function(e) {

	$(document).on("click", ".mt-sentiment-action", function(e) {
		var targetField = $(e.target).closest(".mt-sentiment-action");
		var action = $(targetField).attr("mt-post-action") == "mt-l" ? "like" : "dislike";
		var formData = new FormData();
		formData.append("mt_action", action);
		formData.append("mt_pre_action", currentSentimentAction);
		setCurrentSentimentAction(action, currentSentimentAction);
		var url = "/videos/" + $(targetField).attr("mt-post-data") + "/like_dislike";
		sendAjaxWithNoDataProcessing(url, formData, "POST");
	});
});

function setCurrentSentimentStatus(currentAction, previousAction) {
	if((previousAction == "like" && currentAction == "like") || (previousAction == "dislike" && currentAction == "dislike")) {
		currentSentimentAction = "nothing";
	} else {
		currentSentimentAction = currentAction;
	}
}