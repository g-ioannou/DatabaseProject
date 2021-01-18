$(".real-login").click(function (e) {
	e.preventDefault();
	let errorMessage;
	let validData = true;
	let user_values = {
		username: $("#username-input").val(),
		password: $("#password-input").val(),
	};

	for (let key in user_values) {
		if (user_values[key] === "") {
			validData = false;
		}
	}

	if (validData) {
		$("#login-error").empty();
		$(".input-group-login").css("border", "1px #828282 solid");

		let data = JSON.stringify(user_values);

		$.ajax({
			type: "POST",
			url: "login.php",
			data: { user_values },
			success: function (response) {
				if (response == "fail") {
					$("#login-error").empty();
					$(".input-group-login").css("border", "1px red solid");
					errorMessage = "User can't be found :(";
					$("#login-error").append(errorMessage);
				} else {
					if (response == "Manager") {
						window.location = "./manager/manager.html";
					}
				}
			},
			error: function (error) {
				console.log("no user found");
			},
		});
	} else {
		$("#login-error").empty();
		$(".input-group-login").css("border", "1px red solid");
		errorMessage = "* Please fill all fields!";
		$("#login-error").append(errorMessage);
	}
});

$(".real-register").click(function (e) {
	e.preventDefault();
	let errorMessage;
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
			type: "POST",
			url: "add_user.php",

			data: { user_values },
			success: function (response) {
				$("#registration-msg").empty();
				$(".input-group").css("border", "1px green solid");
				errorMessage = "User " + user_values["username"] + " added!";
				$("#registration-msg").css("color", "green");
				$("#registration-msg").append(errorMessage);
			},
			error: function (error) {
				alert(error);
			},
		});
	} else {
		$("#registration-msg").empty();
		$(".input-group").css("border", "1px red solid");
		errorMessage = "Please fill all fields!";
		$("#registration-msg").css("color", "red");
		$("#registration-msg").append(errorMessage);
	}
});
