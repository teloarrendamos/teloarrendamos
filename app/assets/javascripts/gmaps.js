var geocoder;
var map;
var marker;
var autocomplete;
// initialise the google maps objects, and add listeners
function gmaps_init(){
  // center of the universe
  var latlng = new google.maps.LatLng(3.1379835,101.6081786);

  var options = {
    zoom: 3,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  // create our map object
  map = new google.maps.Map(document.getElementById("gmaps-canvas"), options);

  // the geocoder object allows us to do latlng lookup based on address
  geocoder = new google.maps.Geocoder();

  // the marker shows us the position of the latest address
  marker = new google.maps.Marker({
    map: map,
    draggable: true
  });

  // event triggered when marker is dragged and dropped
  google.maps.event.addListener(marker, 'dragend', function() {
    geocode_lookup( 'latLng', marker.getPosition() );
  });

  // event triggered when map is clicked
  google.maps.event.addListener(map, 'click', function(event) {
    marker.setPosition(event.latLng)
    geocode_lookup( 'latLng', event.latLng  );
  });

  // event triggered when marked is moved
  marker.addListener('position_changed', function() {
    $("#listing_latitude").val(marker.getPosition().lat());
    $("#listing_longitude").val(marker.getPosition().lng());
  });


  $('#gmaps-error').hide();
}

// move the marker to a new position, and center the map on it
function update_map( geometry ) {
  $('#gmaps-error').html("");
  $('#gmaps-error').hide();
  var place = autocomplete.getPlace();
  if (place.name) {
    $('#listing_address_title').val(place.name);
  }
  console.log(place.name)
  if (place.geometry) {
    map.fitBounds( place.geometry.viewport )
    marker.setPosition( place.geometry.location )
  }else{
    $('#gmaps-error').html("Cannot find location based on address, please try somewhere else.");
    $('#gmaps-error').show();
    update_ui('')
  }
}

// fill in the UI elements with new position data
function update_ui( address ) {
  $('#gmaps-input-address').val(address);
}

// Query the Google geocode object
//
// type: 'address' for search by address
//       'latLng'  for search by latLng (reverse lookup)
//
// value: search query
//
// update: should we update the map (center map and position marker)?
function geocode_lookup( type, value, update ) {
  // default value: update = false
  update = typeof update !== 'undefined' ? update : false;

  request = {};
  request[type] = value;

  geocoder.geocode(request, function(results, status) {
    $('#gmaps-error').html('');
    $('#gmaps-error').hide();
    if (status == google.maps.GeocoderStatus.OK) {
      // Google geocoding has succeeded!
      if (results[0]) {
        // Always update the UI elements with new location data
        update_ui( results[0].formatted_address )

        // Only update the map (position marker and center map) if requested
        if( update ) { update_map( results[0].geometry ) }
      } else {
        // Geocoder status ok but no results!?
        $('#gmaps-error').html("Sorry, something went wrong. Try again!");
        $('#gmaps-error').show();
      }
    } else {
      // Google Geocoding has failed. Two common reasons:
      //   * Address not recognised (e.g. search for 'zxxzcxczxcx')
      //   * Location doesn't map to address (e.g. click in middle of Atlantic)
      if( type == 'address' ) {
        // User has typed in an address which we can't geocode to a location
        $('#gmaps-error').html("Sorry! We couldn't find " + value + ". Try a different search term, or click the map." );
        $('#gmaps-error').show();
      } else {
        // User has clicked or dragged marker to somewhere that Google can't do a reverse lookup for
        // In this case we display a warning, clear the address box, but fill in LatLng
        $('#gmaps-error').html("Woah... that's pretty remote! You're going to have to manually enter a place name." );
        $('#gmaps-error').show();
        update_ui('')
      }
    };
  });
};

function initAutocomplete() {
  // Create the autocomplete object, restricting the search to geographical
  // location types.
  autocomplete = new google.maps.places.Autocomplete(
    /** @type {!HTMLInputElement} */
    (document.getElementById('gmaps-input-address')), {});

  autocomplete.addListener('place_changed', update_map);

  // When the user selects an address from the dropdown, populate the address
  // fields in the form.
  // autocomplete.addListener('place_changed', fillInAddress);
}

// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      autocomplete.setBounds(circle.getBounds());
      if($('#gmaps-input-address').val() === ""){
        initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        map.setCenter(initialLocation);
        map.setZoom(15)
      }
    });
  }
}

function initMap(){
  if( $('#gmaps-canvas').length  ) {
    gmaps_init();
    geolocate();
    initAutocomplete();
    // set initial location if form is prefilled ( edit form )
    if($('#listing_longitude').val() !== ""){
      initialLocation = new google.maps.LatLng($('#listing_latitude').val(), $('#listing_longitude').val());
      map.setCenter(initialLocation);
      marker.setPosition( initialLocation )
      map.setZoom(15)
    }
  };   
}

document.addEventListener("turbolinks:load", function() {
  initMap()
});   