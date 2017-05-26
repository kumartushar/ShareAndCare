function sendAjaxWithCustomData(route, formData, type) {
  try{
    $.ajax({
      url: route,
      type: type,
      data: formData,
      contentType: false,
      dataType: "script"
    });
  } catch(e) {
    $.unblockUI();
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

// function isValidKeyPressedForSearch(keycode) {
//   var result = (/[a-zA-Z0-9-_ ]/.test(inp));
//   return result;
// }

// function isValidByExpression(keycode) {
//   return (/[a-zA-Z0-9-_ ]/.test(inp));
// }

// function isValidateByKeycode(keycode) {
//   return [8, 13, 46].indexOf(keycode) > -1;
// }