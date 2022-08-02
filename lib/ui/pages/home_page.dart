import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projectwork/index.dart';

class HomePage extends StatefulWidget {
  // page id
  static const id = BrandStrings.homePage;
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // google map controller
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _mapController;

  bool _isMapLoading = true;

  // polyline
  final List<Polyline> _polyLines = [];
  // markers
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  final Map<CircleId, Circle> _circles = <CircleId, Circle>{};

  // get current position
  _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
    currentPosition = position;
    LatLng pos = LatLng(position.latitude, position.longitude);
    _mapController.animateCamera(CameraUpdate.newLatLng(pos));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            /* google maps widget */
            Container(
              color: BrandColors.kColorBackground,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: googlePlex,
                padding: const EdgeInsets.only(top: 10.0),
                trafficEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                rotateGesturesEnabled: true,
                compassEnabled: true,
                zoomControlsEnabled: true,
                polylines: Set<Polyline>.of(_polyLines),
                markers: Set<Marker>.of(_markers.values),
                circles: Set<Circle>.of(_circles.values),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  _mapController = controller;
                  _getCurrentPosition();
                  setState(() {
                    _isMapLoading = false;
                  });
                },
              ),
            ),
            (_isMapLoading)
                ? Container(
                    height: BrandSizes.designHeight,
                    width: BrandSizes.designWidth,
                    color: BrandColors.kColorBackground,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 10.0,
                        backgroundColor: BrandColors.kColorBackground,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
