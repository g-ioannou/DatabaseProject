$.ajax({
	type: "GET",
	url: "../get_username.php",

	success: function (response) {
        
		$(".username").append("   " +response + "!");
	},
});
