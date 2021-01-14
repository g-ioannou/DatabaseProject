$("#login-btn").css("background", "white");
$("#login-btn").css("color", "#212529");

$(".register-content").hide();

$("#login-btn").click(function (e) {
   e.preventDefault();
   $("#register-btn").css("background", "#212529");
   $("#register-btn").css("color", "white");
   $(this).css("background", "white");
   $(this).css("color", "#212529");
   $(".register-content").hide();
   $(".login-content").show();
});

$("#register-btn").click(function (e) {
   e.preventDefault();
   $("#login-btn").css("background", "#212529");
   $("#login-btn").css("color", "white");
   $(this).css("background", "white");
   $(this).css("color", "#212529");
   $(".login-content").hide();
   $(".register-content").show();
});

$("#manager").click(function (e) {
   e.preventDefault();

   $("#position").empty();
   $("#position").append("Manager");
   $("#chooser").hide();
});

$("#evaluator").click(function (e) {
   e.preventDefault();

   $("#position").empty();
   $("#position").append("Evaluator");
   $("#chooser").hide();
});

$("#employee").click(function (e) {
   e.preventDefault();

   $("#position").empty();
   $("#position").append("Employee");
   $("#chooser").hide();
});

$("#admin").click(function (e) {
   e.preventDefault();

   $("#position").empty();
   $("#position").append("Admin");
   $("#chooser").hide();
});

$("#registration-error").css("color", "red");
$("#login-error").css("color", "red");
