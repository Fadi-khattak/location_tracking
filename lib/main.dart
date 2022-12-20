import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:location_tracking/client_module/client_home.dart';
import 'package:location_tracking/firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

import 'mymap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp( MaterialApp(home: ClientHome()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('live location tracker'),
      ),
      body: StreamBuilder(
        stream:
        FirebaseFirestore.instance.collection('location').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            return ListTile(
              title:
                  Text(snapshot.data!.docs[index]['name'].toString()),
              subtitle: Row(
                children: [
                  Text(snapshot.data!.docs[index]['latitude']
                      .toString()),
                 const SizedBox(
                    width: 20,
                  ),
                  Text(snapshot.data!.docs[index]['longitude']
                      .toString()),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.directions),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          MyMap(snapshot.data!.docs[index].id)));
                },
              ),
            );
          });
        },
      ),
    );
  }






}
