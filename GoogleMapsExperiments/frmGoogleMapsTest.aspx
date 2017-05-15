<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmGoogleMapsTest.aspx.cs" Inherits="GoogleMapsExperiments.frmGoogleMapsTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Google Maps with Multiple marker with polygon</title>
    <style type="text/css">
        #mapContainer {
            height: 650px;
        }

        #mapCanvas {
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCfLIjHiYew7GVtGFCupnouk4RDOGv8f68"></script>
            <script>
                function initMap() {
                    var map;
                    var bounds = new google.maps.LatLngBounds();
                    var mapOptions = {
                        mapTypeId: 'roadmap'
                    };
                    // Display a map on the web page
                    map = new google.maps.Map(document.getElementById("mapCanvas"), mapOptions);
                    map.setTilt(50);
                    // Multiple markers location, latitude, and longitude
                    var markers = [
                        ['IISc Guest House', 13.02154437, 77.56836355],
                        ['JRD Tata Memorial Library', 13.01638056, 77.56593883],
                        ['Dept. of Electronics Systems Engineering', 13.01880568, 77.57072389]
                    ];
                    // Info window content
                    var infoWindowContent = [
                        ['<div class="info_content">' +
                        '<h3>IISc Guest House</h3>' +
                        '<p>IISc Guest House</p>' + '</div>'],
                        ['<div class="info_content">' +
                        '<h3>JRD Tata Memorial Library</h3>' +
                        '<p>JRD Tata Memorial Library</p>' +
                        '</div>'],
                        ['<div class="info_content">' +
                        '<h3>Dept. of Electronics Systems Engineering</h3>' +
                        '<p>Dept. of Electronics Systems Engineering</p>' +
                        '</div>']
                    ];
                    // Add multiple markers to map
                    var infoWindow = new google.maps.InfoWindow(), marker, i;
                    // Place each marker on the map  
                    for (i = 0; i < markers.length; i++) {
                        var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
                        bounds.extend(position);
                        marker = new google.maps.Marker({
                            position: position,
                            map: map,
                            title: markers[i][0]
                        });
                        // Add info window to marker    
                        google.maps.event.addListener(marker, 'click', (function (marker, i) {
                            return function () {
                                infoWindow.setContent(infoWindowContent[i][0]);
                                infoWindow.open(map, marker);
                            }
                        })(marker, i));
                        // Center the map to fit all markers on the screen
                        map.fitBounds(bounds);
                    }
                    // Set zoom level
                    var boundsListener = google.maps.event.addListener((map), 'bounds_changed', function (event) {
                        this.setZoom(16);
                        google.maps.event.removeListener(boundsListener);
                    });
                    var triangleCoords = [
                     { lat: 13.02154437, lng: 77.56836355 },
                     { lat: 13.01638056, lng: 77.56593883 },
                     { lat: 13.01880568, lng: 77.57072389 },
                     { lat: 13.02154437, lng: 77.56836355 },
                    ];

                    // Construct the polygon.
                    var iiscTriangle = new google.maps.Polygon({
                        paths: triangleCoords,
                        strokeColor: '#FF0000',
                        strokeOpacity: 0.8,
                        strokeWeight: 2,
                        fillColor: '#FF0000',
                        fillOpacity: 0.35
                    });
                    iiscTriangle.setMap(map);
                }
                // Load initialize function
                google.maps.event.addDomListener(window, 'load', initMap);
            </script>
            <div id="mapContainer">
                <div id="mapCanvas"></div>
            </div>

        </div>
    </form>
</body>
</html>
