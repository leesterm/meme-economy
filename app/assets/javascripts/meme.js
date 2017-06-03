// Since turbolinks caches js, we must handle load instead of document ready
//$(document).on("turbolinks:load",function(){
$(document).ready(function(){
  //$('#trend').css( "border", "3px solid red" );
  $.ajax({
    url: "http://www.google.com/trends/fetchComponent",
    //url: "http://html5rocks-cors.s3-website-us-east-1.amazonaws.com/index.html",
    type: 'GET',
    hl: 'en-US',
    q: ['pepe'],
    cid: 'TIMESERIES_GRAPH_0',
    export: 5,
    success: function(data, textStatus, jqXHR){
      $('body').append("Successful AJAX call:"+data);
    },
    error: function(jqXHR, textStatus, errorThrown){
      $('body').append("AJAX Error: "+textStatus);
    }
  })
});
