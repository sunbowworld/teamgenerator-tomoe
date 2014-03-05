// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){

  var teams

  $('.steam_card').click(function(){
    switchClassParent($(this),'.user_list','.tg_user')
  })

  $('.teams_value').click(function(){
    $('.number_of_teams > .value').text($(this).text())
  })

  $('.generator').click(function(){
    var teamValue = $('.number_of_teams > .value').text()
    var tmp
    var users = []
    teams = []

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
      $('.tg_result').prepend($('<div />', {id: "team"+(i+1),class: "col-lg-"+12/teams.length}))
      $('#team'+(i+1)).append($('<div />', {class: "panel panel-primary"}))
      $('#team'+(i+1)+' > .panel').append($('<div />',{class: "panel-heading",text: "team"+(i+1)}))
      $('#team'+(i+1)+' > .panel').append($('<div />',{class: "panel-body"}))
      for(var j=teams[i].length; j--;){
        $('#team'+(i+1)+' .panel-body').append($('#'+teams[i][j]))
      }
    }
  })

  $('#submit').click(function(){
    $("#form").append($('<input/>', {type: 'hidden', name: 'json', value: JSON.stringify({teams: teams})}))
    $("#form").submit()
  })

})