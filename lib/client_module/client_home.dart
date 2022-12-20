import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({Key? key}) : super(key: key);

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;


  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _listenLocation();
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
  @override
  void didChangeDependencies() {
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/location.gif",
              height: 200,
              width: 200,
            ),
            const SizedBox(
              height: 10,
            ),
             Text(_locationSubscription==null? "location sharing is off" :"Your app is sharing location"),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: ()async{
                if(_locationSubscription==null){
                  _listenLocation();
                }else{
                  await FirebaseFirestore.instance.collection('location').doc('client').delete();
                  _stopListening();
                }
              },
              child:  Text(_locationSubscription==null? "start sharing" :"stop sharing"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc('client').set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'Fahad'
      }, SetOptions(merge: true));
    });
    setState(() {

    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }
}
