import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class MyMap extends StatefulWidget {
  final String user_id;

  MyMap(this.user_id);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  final GlobalKey _globalKey = GlobalKey(debugLabel: 'default');
  bool _added = false;
  BitmapDescriptor? customIcon;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('location').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (_added) {
                mymap(snapshot);
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return GoogleMap(
                mapType: MapType.terrain,
                markers: {
              Marker(
              position: LatLng(
              snapshot.data!.docs.singleWhere((element) =>
              element.id == widget.user_id)['latitude'],
              snapshot.data!.docs.singleWhere((element) =>
              element.id == widget.user_id)['longitude'],
              ),
              markerId: MarkerId('id'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
              ),
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      snapshot.data!.docs.singleWhere((element) =>
                          element.id == widget.user_id)['latitude'],
                      snapshot.data!.docs.singleWhere((element) =>
                          element.id == widget.user_id)['longitude'],
                    ),
                    zoom: 20.47),
                onMapCreated: (GoogleMapController controller) async {
                  
                  setState(() {
                    _controller = controller;
                    _added = true;
                  });
                },
              );
            },
          ),
        ),
      ],
    ));
  }

  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['latitude'],
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['longitude'],
            ),
            zoom: 14.47)));
  }
}
