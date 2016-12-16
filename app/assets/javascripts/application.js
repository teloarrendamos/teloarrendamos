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
//= require turbolinks
//= require twitter/typeahead.min
//= require keyboard
//= require listings

// Login Nav Dropdown
$(document).on('turbolinks:load', function(){
	var loginDropdownButton = document.getElementById("login-dropdown-button");
	var loginDropdown = document.getElementById("login-dropdown");
	var signUpDropdownButton = document.getElementById("sign-up-dropdown-button");
	var signUpDropdown = document.getElementById("sign-up-dropdown");
		
	loginDropdownButton.addEventListener('mouseover', function (event) {
	    loginDropdown.style.display = "block";
	});

	loginDropdownButton.addEventListener('mouseleave', function (event) {
	    loginDropdown.style.display = "";
	});

	signUpDropdownButton.addEventListener('mouseover', function (event) {
		signUpDropdown.style.display = "block";
	});

	signUpDropdownButton.addEventListener('mouseleave', function (event) {
	    signUpDropdown.style.display = "";
	});
});


// Toggle for FAQ page answers
$(document).on('turbolinks:load', function(){
	var questions = document.getElementsByClassName('question');

	Array.prototype.forEach.call(questions, function(question) {
		var originalColor = question.style.color;

		question.addEventListener('click', function() {
			var answer = this.nextElementSibling;
			var plusSign = this.childNodes[1];
			var minusSign = this.childNodes[2];

			if(answer.style.display === "") {
				answer.style.display = "block"
				plusSign.style.display = "none";
				minusSign.style.display = 'inline';
				this.style.color = 'grey';
			} else {
				answer.style.display = "";
				minusSign.style.display = ""
				plusSign.style.display = "inline";
				this.style.color = originalColor;
			}
		});
	});
});


//Slider Mechanism ----------------------------
$(document).on('turbolinks:load', function(){
	function Slider( element ) {
		this.el = document.querySelector( element );
		this.init();
	}	

	Slider.prototype = {
		init: function() {
			this.links = this.el.querySelectorAll( "#slider-nav a" );
			this.wrapper = this.el.querySelector( "#slider-wrapper" );
			this.navigate();
		},
		navigate: function() {
		
			for( var i = 0; i < this.links.length; ++i ) {
				var link = this.links[i];
				this.slide( link );	
			}
		},
		
		animate: function( slide ) {
			var parent = slide.parentNode;
			var caption = slide.querySelector( ".caption" );
			var captions = parent.querySelectorAll( ".caption" );
			for( var k = 0; k < captions.length; ++k ) {
				var cap = captions[k];
				if( cap !== caption ) {
					cap.classList.remove( "visible" );
				}
			}
			caption.classList.add( "visible" );	
		},
		
		slide: function( element ) {
			var self = this;
			element.addEventListener( "click", function( e ) {
				e.preventDefault();
				var a = this;
				self.setCurrentLink( a );
				var index = parseInt( a.getAttribute( "data-slide" ), 10 ) + 1;
				var currentSlide = self.el.querySelector( ".slide:nth-child(" + index + ")" );
				
				self.wrapper.style.left = "-" + currentSlide.offsetLeft + "px";
				self.animate( currentSlide );
				
			}, false);
		},

		setCurrentLink: function( link ) {
			var parent = link.parentNode;
			var a = parent.querySelectorAll( "a" );
			
			link.className = "current";
			
			for( var j = 0; j < a.length; ++j ) {
				var cur = a[j];
				if( cur !== link ) {
					cur.className = "";
				}
			}
		}	
	};

	if (true) {}$("")
		if($(".pages.how_it_works").length > 0) {
			var aSlider = new Slider( "#slider" );		
		}
		
});
	


