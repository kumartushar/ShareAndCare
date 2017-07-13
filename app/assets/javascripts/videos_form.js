$(document).ready(function(e) {
  var tagCount = 0;

  $(".tag-container").mCustomScrollbar({
    set_width : false,
    set_height : false,
    horizontalScroll : false,
    scrollbarPosition: "inside",
    scrollInertia : 950,
    autoHideScrollbar: false, //will hide the scrollbar(s) when scrolling is idle and/or cursor is out of the scrolling area.
    mouseWheel : true,
    mouseWheelPixels : "auto",
    scrollButtons: {
      enable: false,
      scrollAmount: "auto",
      scrollType: "stepless"
    },
    keyboard: {
      enable: true,
      scrollAmount: "auto",
      scrollType: "stepless"
    },
    contentTouchScroll: true,
    advanced: {
      updateOnContentResize: true,
      updateOnBrowserResize: true,
      autoExpandHorizontalScroll: false,
      autoScrollOnFocus: true,
      normalizeMouseWheelDelta : false
    },
    callbacks : {
      onScrollStart : function() {
      }, /*user custom callback function on scroll start event*/
      onScroll : function() {
      }, /*user custom callback function on scroll event*/
      onTotalScroll : function() {
      }, /*user custom callback function on scroll end reached event*/
      onTotalScrollBack : function() {
      }, /*user custom callback function on scroll begin reached event*/
      onTotalScrollOffset : 0, /*scroll end reached offset: integer (pixels)*/
      onTotalScrollBackOffset : 0, /*scroll begin reached offset: integer (pixels)*/
      whileScrolling : function() {
      } /*user custom callback function on scrolling event*/
    },
    theme : "light"
  });

  $("#mt-upload-meta").find("*").prop("disabled", true);

  // $("#target_video").change(function(e){
    // $("#mt-file-upload-title").text("File Selected: " + this.value);
    // $("#mt-file-title-box").show();
    // $("#mt-upload-meta").find("*").prop("disabled", false);
    // $("#mt-upload-submit").prop("disabled", false);
  //   alert("hi");
  // });
  $(document).on("change", "#target_video", function(e) {
    var formData = new FormData();
    formData.append("target_file", e.target.files[0]);

    //------------------AJAX with JQuery
    $.ajax({
      url: '/upload_video',
      type: 'POST',
      data: formData,
      cache: false,
      dataType: 'script',
      processData: false, // Don't process the files,  Because jQuery will convert the files arrays into strings and the server can't pick it up.
      contentType: false, // Set content type to false as jQuery will tell the server its a query string request, if true it doesnt send the files
      success: function(data, textStatus, jqXHR) {
        alert("file uploaded successfully");
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Error uploading file");
      }
    });

    //------------------ AJAX with pure JavaScript
    // var token = $( 'meta[name="csrf-token"]' ).attr( 'content' );
    // var xhr = new XMLHttpRequest();
    // xhr.open('POST', "/upload_video", true);
    // xhr.onload = function() {
    //   if (xhr.status === 200) {
    //     alert("file uploaded successfully");
    //   } else {
    //     alert("Error File Uploading");
    //   }
    // };
    // xhr.setRequestHeader( 'X-CSRF-Token', token );
    // xhr.send(formData);
  });

  $(document).on("click", "#mt-add-tag-btn", function(e) {
    var tag = $("#tag-input-field").val().trim();
    if (tag == "") {
      alert("Blank tag cannot be added");
    } else {
      if (!is_already_exist(tag)) {
        tagCount += 1;
        $(".tag-container").append('<div class="tag-item-box"><div class="tag-item"><span class="tag-text">' + tag + '</span><input type="hidden" name="video[v_tags['+ tagCount +']]" value="' + tag + '"></div><div class="tag-item-delete-icon">x</div></div>');
        $("#tag-input-field").val('');
        changeVisibilityOfTagContainer();
      } else {
        // showAlreadyExistsMsg
        alert("already exist");
      }
    }
  });

  $(document).on("click", ".tag-item-delete-icon", function(e) {
    $(e.target).closest(".tag-item-box").remove();
    tagCount -= 1;
    changeVisibilityOfTagContainer();
  });
});

function is_already_exist(tag) {
  var result = false;
  $.each($(".tag-text"), function(i, node) {
    if ($(node).text() == tag) {
      result = true;
    }
  });
  return result;
}

function changeVisibilityOfTagContainer() {
  if (tagCount == 0) {
    $(".tag-container").hide();
  } else if (tagCount == 1) {
    $(".tag-container").show();
  }
}