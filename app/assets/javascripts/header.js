$(document).ready(function() {
	setActiveTab();
});

function setActiveTab() {
	switch(active_page) {
		case "home":
			$("#home-tabspace").removeClass("active").addClass("active");
			break;
		case "blogs":
			$("#blogs-tabspace").removeClass("active").addClass("active");
			break;
		case "videos":
			$("#videos-tabspace").removeClass("active").addClass("active");
			break;
		default:
			$("#home-tabspace").removeClass("active").addClass("active");
	}
}