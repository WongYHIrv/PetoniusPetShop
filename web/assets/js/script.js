/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

(function(window, google) {
    
    //Map options
    var options = {
        center: {
            lat: '37.791350',
            lng: '-122.435883'
        },
        zoom: 10
    },
    element = document.getElementById('map-canvas'),
    //Map
    map = new google.maps.Map(element, options);
}(window, google));
