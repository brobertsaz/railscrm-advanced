$(document).ready(function(){
  $('#add_new_note').click(function(e) {
    e.preventDefault();
    $('.new_note_section').css("display", "block");
  });
});