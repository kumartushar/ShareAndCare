$(document).ready(function(e) {
  var tagCount = 0;

  $.cloudinary.config({ cloud_name: 'share-and-care', api_key: '578912338145794'});

  $(function() {
    if($.fn.cloudinary_fileupload !== undefined) {
      $("input.cloudinary-fileupload[type=file]").cloudinary_fileupload();
    }
  });
  
  $('.cloudinary-fileupload').bind('cloudinarydone', function(e, data) {
    // $('.preview').html(
    // $.cloudinary.image(data.result.public_id,
    //   { format: data.result.format, version: data.result.version,
    //     crop: 'fill', width: 150, height: 100 })
    // );
    // $('.image_public_id').val(data.result.public_id);
    $('.progress-bar').removeClass('progress-bar-info').addClass("progress-bar-success");
    $("#mt-upload-progress-text").text("Click 'Upload' to make your video live.");
    return true;
  });

  $('.cloudinary-fileupload').bind('fileuploadprogress', function(e, data) {
    var loadPercent = Math.round((data.loaded * 100.0) / data.total) + '%';
    $('.progress-bar').css('width', loadPercent).text(loadPercent);
  });


  $("#video_upload_tag").change(function(e){
   $("#mt-video-details-block").removeClass("hidden");
   $("#mt-upload-video-widget").addClass("hidden");
  });

  InitializeTagContainer();

  $(document).on("click", "#mt-add-tag-btn", function(e) {
    var tag = $("#tag-input-field").val().trim();
    if (tag === "") {
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

  $(document).on("click", "#mt-upload-prompt-box", function(e) {
    $("#video_upload_tag").click();
  });
});


function InitializeTagContainer() {
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
}
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