$(document).ready(function(e) {
	$("#add_blog_category_form").validationEngine();
	$("#add_video_category_form").validationEngine();

	$(document).on("submit", "#add_blog_category_form, #add_blog_category_form", function(e) {
		var isValidForm = $(e.target).validationEngine('validate');
		if (!isValidForm) {
			return false;
		}
	});
});

function resetCategoryFields() {
	$("#blog_category_name").val('');
	$("#video_category_name").val('');
}