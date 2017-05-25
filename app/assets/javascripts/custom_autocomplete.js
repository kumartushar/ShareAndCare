function customAutoComplete(options) {
	options = getNewOptions(options);
	if (options["id"] !== "") {
		var timer;
		$(document).on("keydown", "#" + options["id"], function(e) {
			clearInterval(timer);
			timer = setTimeout(function() {
				var keyCode = e.keyCode;
				if (isValidKeyPressedForSearch(keyCode)) { //if alphanumeric characters or backspace then search content
					sendSearchRequest(options);
				}
			}, 150);
		});
	}
}

function getNewOptions(options) {
	var newOptions =  $.extend({id: '', url: '', minLength: 3, params: '', isSearchForBlank: false}, options);
  return newOptions;
}

function sendSearchRequest(options) {
	var inputField = $("#" + options["id"]);
	var userInput = inputField.val();
	var searchText = escape(userInput.trim());
	var params = $.extend(options.params, {search_text: searchText});


	if((userInput.length >= options["minLength"]) || (options["isSearchForBlank"] && userInput.length === 0)) {
    if (searchText !== "") {
			$.ajax({
				url: options.url,
				type: 'GET',
				data: params,
				datatype: 'script'
			});
    }
	} else {
		closeCustomAutoComplete();
	}
}