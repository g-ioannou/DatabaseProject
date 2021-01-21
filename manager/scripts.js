let choseCompany = false;

$.ajax({
	type: "GET",
	url: "../get_username.php",
	success: function (response) {
		$(".username").append("   " + response);
	},
});

$.ajax({
	type: "POST",
	url: "../get_loggin_times.php",
	success: function (response) {
		console.log(response);
		if (response == '0') {
			$.ajax({
				type: "GET",
				dataType: "json",
				url: "manager-set-company.php",
				success: function (response) {
					for (let company = 0; company < response.length; company++) {
						const companyName = response[company];

						let companyBtn = '<button type=button class="btn list-btn companies-btn">' + companyName + "</button>";
						$(".companies").append(companyBtn);
					}
				},
			});

			$(".companies").on("click", ".companies-btn", function () {
				$("#chooser").empty();
				$(".first-time-msg").empty();
				$(".input-group").css("border", "1px green solid");
				$("#chooser").append($(this).text());
				choseCompany = true;
			});

			$(".continue-to-main").click(function (e) {
				e.preventDefault();

				let expYears = $("#real-input-years").val();
				let flag = false;

				let temp = parseInt(expYears);
				if (temp < 0 || temp > 100 || isNaN(temp)) {
					$(".first-time-msg").empty();
					$(".first-time-msg").append("Please enter a valid number of experience years (0-99)");
					$("#real-input-years").css("border", "1px red solid");
				} else if (choseCompany == false) {
					$(".first-time-msg").empty();
					$(".first-time-msg").append("Please choose a company");
					$(".input-group").css("border", "1px red solid");
				} else {
					$(".first-time-msg").empty();
					$("#real-input-years").css("border", "1px green solid");

					let managerInfo = {
						managerUsername: $(".username").text(),
						managerCompany: $("#chooser").text(),
						managerExperience: $("#real-input-years").val(),
					};
					managerInfo.managerUsername = managerInfo.managerUsername.trimLeft();

					$.ajax({
						type: "POST",
						url: "manager-info-post.php",

						data: { managerInfo },
						success: function (response) {
							console.log(response);
						},
					});
				}
			});
		} else {
			$('.first-time').hide();
		}
	},error: function (error){
		console.log(error);
	}
});
