$(document).ready(function(e) {
	customAutoComplete({
		id: "blog-search-input",
		url: "/blogs/search",
		isSearchForBlank: false
	});

	$(document).on("click", ".blog-row", function(e) {
		var blogID = $(e.target).closest(".blog-row").attr("ele-id");
		window.location.href = '/blogs/' + blogID;
	});

	addEllipsisToDescription();

	$(document).on("click", ".blog-search-row", function(e) {
		var blogID = $(e.target).closest(".blog-search-row").attr("item-id");
		window.location.href = '/blogs/' + blogID;
	});

	$(document).on("click", "body", function(e) {
		closeCustomAutoComplete();
	});

	$('.selectpicker').selectpicker();

});

function closeCustomAutoComplete() {
	$("#blog-search-result").hide();
}

function addEllipsisToDescription() {
	var showChar = 500;
	var ellipsestext = "....read more >>";
	var moretext = "more";
	var lesstext = "less";
	$('.blog-description').each(function() {
		var content = $(this).html();

		if(content.length > showChar) {

			var c = content.substr(0, showChar);
			var h = content.substr(showChar-1, content.length - showChar);

			var html = c + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span>';

			$(this).html(html);
		}

	});
}