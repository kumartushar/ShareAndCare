function sendAjax(route, formData, type) {
  try{
    $.ajax({
      url: route,
      type: type,
      data: formData,
      dataType: "script",
      contentType: false
    });
  } catch(e) {
    console.log(e.message);
  }
}

function sendAjaxWithNoDataProcessing(route, formData, type) {
  try{
    $.ajax({
      url: route,
      type: type,
      data: formData,
      cache: false,
      dataType: "script",
      processData: false,
      contentType: false
    });
  } catch(e) {
    console.log(e.message);
  }
}

function isValidKeyPressedForSearch(keyCode) {
  var isValid = true;
  var inValidKeyCodes = [9, 18, 19, 20, 27, 33, 34, 35, 36, 37, 38, 39, 40, 42, 45, 92, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 144, 145];
  if (inValidKeyCodes.indexOf(keyCode) > -1) {
    isValid = false;
  }
  return isValid;
}

function showSmallModal(title, body, isHtmlBody = false) {
  showModal(title, body, "small", isHtmlBody);
}

function showLargeModal(title, body, isHtmlBody = false) {
  showModal(title, body, "large", isHtmlBody);
}
function showModal(title, body, sizeClass, isHtmlBody) {
  $("#my-modal-header-text").text(title);
  if (isHtmlBody) {
    var htmlBody = $.parseHTML(body);
    $("#modal-body").html(htmlBody);  
  } else {
    var textBody = $.parseHTML('<p id="my-modal-body-text">' + body + '</p>');
    $("#modal-body").html(textBody);
  }
  $(".footer-btn").addClass("hidden");
  sizeClass == "small" ? $("#my-modal-dialog").removeClass("modal-lg").addClass("modal-sm") : $("#my-modal-dialog").removeClass("modal-sm").addClass("modal-lg");
  $("#showModalPopupBtn").trigger('click');
}