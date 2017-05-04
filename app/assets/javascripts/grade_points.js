$(document).ready(function(){
  $('#test').on("click", function(){

    var student_id = window.location.href;

    var regex = /(\d+)/g;

    var arrays = student_id.match(regex);
    student_id = arrays[arrays.length - 1];

    var val = 0;

      $.ajax({
      type: 'PATCH',
      url: '/students/' + student_id + '/grades/',
      data: {grade: {earned_points: val }},
      success: function(data) {
      console.log("Success");
      }
    });
  });
});

// this gets the right student_id and sends a request
