$(".real-login").click(function (e) {
   e.preventDefault();
   let validData = true;
   let user_values = {
      username: $("#username-input").val(),
      password: $("#password-input").val(),
   };

   for (let key in user_values) {
      if (user_values[key] === "") {
         validData = false;
         console.log(user_values);
      }
   }

   if (validData) {
      $("#login-error").empty();
      $(".input-group-login").css("border", "1px #828282 solid");

      let data = JSON.stringify(user_values);

      $.ajax({
         type: "GET",
         url: "login.php",
         success: function (response) {
            console.log(response);
         },
      });
   } else {
      $("#login-error").empty();
      $(".input-group-login").css("border", "1px red solid");
      let errorMessage = "* Please fill all fields!";
      $("#login-error").append(errorMessage);
   }
});

$(".real-register").click(function (e) {
   e.preventDefault();
   let validData = true;
   let user_values = {
      name: $("#name").val(),
      surname: $("#surname").val(),
      email: $("#email").val(),
      username: $("#new-username").val(),
      password: $("#new-password").val(),
      position: $("#position").text(),
   };

   for (let key in user_values) {
      if (user_values[key] === "") {
         validData = false;
      }
   }

   if (validData) {
      $("#registration-error").empty();
      $(".input-group").css("border", "1px #828282 solid");
      let data = JSON.stringify(user_values);

      $.ajax({
         type: "get",
         url: "add_user.php",

         success: function (response) {
            console.log(response);
         },
      });
   } else {
      $("#registration-error").empty();
      $(".input-group").css("border", "1px red solid");
      let errorMessage = "* Please fill all fields!";
      $("#registration-error").append(errorMessage);
   }
});
