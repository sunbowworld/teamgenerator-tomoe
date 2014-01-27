// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  $('.steam_card').click(function(){
    switchClassParent($(this),'.user_list','.tg_user')
  })
  $('.generator').click(function(){
    var teamValue = $('.number_of_teams > .value').text()
    //var userValue = $('.number_of_users > .value').text()
    var teams = []
    var tmp
    var users = []

    $('.tg_area .steam_card').appendTo($('.tg_user'))
    $('.tg_result').empty()

    $('.tg_user').children('.steam_card').each(function(){
      users.push($(this).attr('id'))
    })
    userValue = parseInt(users.length/teamValue)
    var sUsers = shuffle(users)
    for (var i=teamValue; i--;){
      tmp = []
      for (var j =userValue; j--;) {
        tmp.push(sUsers.pop())
      }
      teams.push(tmp)
    }

    for (var i=teams.length; i--;){
      $('.tg_result').prepend($('<div />', {id: "team"+(i+1),class: "col-lg-6"}))
      $('#team'+(i+1)).append($('<div />', {class: "panel panel-primary"}))
      $('#team'+(i+1)+' > .panel').append($('<div />',{class: "panel-heading",text: "team"+(i+1)}))
      $('#team'+(i+1)+' > .panel').append($('<div />',{class: "panel-body"}))
      for(var j=teams[i].length; j--;){
        $('#team'+(i+1)+' .panel-body').append($('#'+teams[i][j]))
      }
    }
  })
  $('.teams_value').click(function(){
    $('.number_of_teams > .value').text($(this).text())
  })
})