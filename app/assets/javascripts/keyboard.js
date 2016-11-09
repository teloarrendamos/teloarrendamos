$( document ).on( 'keyup keypress', 'input, textarea', function( e ){
  var charCode = ( e.which ) ? e.which : e.keyCode;
  if( charCode == 13 ){
    e.preventDefault();
    return false;
  }
});