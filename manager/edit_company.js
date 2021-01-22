$("#edit-company-info").click(function (e) {
	e.preventDefault();
	//all code here
});

$("#submit-company-edit").click(function (e) {
	e.preventDefault();

	//new items
	$.ajax({
		type: "POST",
		url: "../get_company.php",
		dataType: "json",
		success: function (response) {
			let companyName = response[0].name;

			let user_values = { "name": companyName};

			let newCompanyPhone = $("#new-company-phone").val();
			let newCompanyStreet = $("#new-company-street").val();
			let newCompanyStreetNum = $("#new-company-street-num").val();
			let newCompanyCity = $("#new-company-city").val();
			let newCompanyCountry = $("#new-company-country").val();

			if (newCompanyPhone != "") {
				user_values["phone"] = newCompanyPhone;
			}

			if (newCompanyStreet != "") {
				user_values["street"] = newCompanyStreet;
			}

			if (newCompanyStreetNum != "") {
				user_values["street_num"] = newCompanyStreetNum;
			}

			if (newCompanyCity != "") {
				user_values["city"] = newCompanyCity;
			}

			if (newCompanyCountry != "") {
				user_values["country"] = newCompanyCountry;
			}

			$.ajax({
				type: "POST",
				url: "../edit_company.php",
				data: { user_values },
				success: function (response) {
                    console.log(response);
                },
			});
		},
	});
});
