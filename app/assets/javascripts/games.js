// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


jQuery(document).ready(function(){
  var player = $("#game_current_player").val();
  var player_class = "fa-circle-o";
  var score = $("#game_score").val();
  if(player == "x") {
    var player_class = "fa-times";
  } 
  var player_class_hov = player_class + " hov"

    
    setSpots();
    if(score != "") {
      $("#display-table > tbody > tr > td").removeClass("available");
    }

  $("td.available").click(function() {
    $("#photo_upload_progress").show();
    var index = this.id[this.id.length -1];
    
    // $(this).unbind('mouseenter mouseleave');
    $("td").off('mouseenter mouseleave');
    $(this).find("i").removeClass("hov").addClass(player_class);
    $("#display-table > tbody > tr > td").removeClass("available");
    $("#board_"+index).val(player);
     if(player == "x"){
        player = "o";
     } else {
      player = "x";
    }
    $("#game_current_player").val(player);

    $("div.actions input").click()
  });


  $( "td.available").hover(function() {
   $(this).find("i").toggleClass(player_class_hov);
  });

  $(".player-starts").click(function(event){
    event.preventDefault();
    $("div.actions input").click()
  });

  if($('#game_status_man').is(":checked")) {
    $(".myIcons").css("display", "none");
   } 

  $('#game_status_man').change(function() {
    var msg = "";
    if($(this).is(":checked")) {
      $(".myIcons").css("display", "none");
      if($("#game_level").val() == '1') {
        msg = "<h3> Click on the grid to start. X makes the first move. </h3>";
      } else {
        msg = "<h3> Next move by " + player;
      }
      $("#instruct").html(msg);
     }
    });

  $('#game_status_comp').change(function() {
    var msg = "";
    if($(this).is(":checked")) {
      $(".myIcons").css("display", "block");
      if($("#game_level").val() == '1') {
        msg = "<h4> Click on the grid to or the icon below. </h4>";
      } else {
        msg = "<h3> Next move by " + player;
      }
      $("#instruct").html(msg);
     } 
    });

  function setSpots () {
    for(var i = 0; i<9; i++){
      if($("#board_"+i).val() == "x"){
        $("#display_cell_"+i).find("i").addClass("fa-times");
        $("#display_cell_"+i).removeClass("available");
      } else if($("#board_"+i).val() == "o"){
        $("#display_cell_"+i).find("i").addClass("fa-circle-o");
        $("#display_cell_"+i).removeClass("available");
      }
  }
  }

});
