// functionalities
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// initial camera position
const CameraPosition googlePlex = CameraPosition(
  target: LatLng(6.673175, -1.565423),
  zoom: 18.4746,
);

late Position currentPosition;
// google map id
String get mapKey => 'AIzaSyCWG3_YJnepd_mVCfv-sAIDTkCAjkCSGqU';

//change defaultLatLng to default country [LAT_LNG] if the user didn't provide any location
const LatLng defaultLatLng = LatLng(30.033333, 31.233334);
const double defaultMapZoom = 18.4746;
const double mediumMapZoom = 14.0;
const int locationChangeInterval = 5000; //in milliseconds
const double locationChangeDistance = 5.0; //in meters
const double locationArriveDistance = 200.0; //in meters
