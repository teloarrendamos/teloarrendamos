// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require gmaps
//= require keyboard
//= require typeahead
//= require listings


// Toggle for show/hide login nav buttons
$(document).on('turbolinks:load', function(){
	var loginDropdownButton = document.getElementById("login-dropdown-button");
	var loginDropdown = document.getElementById("login-dropdown");
	var signUpDropdownButton = document.getElementById("sign-up-dropdown-button");
	var signUpDropdown = document.getElementById("sign-up-dropdown");
		
	loginDropdownButton.addEventListener('click', function (event) {
	    var next = loginDropdown;

	    if (next.style.display == "") {
	        next.style.display = "block";

	    } else {
	        next.style.display = "";
	    }
	});

	signUpDropdownButton.addEventListener('click', function (event) {
	    var next = signUpDropdown;

	    if (next.style.display == "") {
	        next.style.display = "block";

	    } else {
	        next.style.display = "";
	    }
	});
});


// Toggle for FAQ page answers
// $(document).on('turbolinks:load', function(){
	
// });