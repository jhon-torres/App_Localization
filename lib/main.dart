import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_am/screens/home_screen.dart';
import 'package:proyecto_am/screens/login_screen.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  Location location = new Location();

  Future<LocationData?> _determinePosition() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  void updateLocation(double? newLatitud, double? newLongitud) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final currentUser = FirebaseAuth.instance.currentUser;
    try {
      await _firestore.collection('locations').doc(currentUser?.uid).update({
        'latitud': newLatitud,
        'longitud': newLongitud,
      });
      print('Ubicación actualizada exitosamente.');
    } catch (e) {
      print('Error al actualizar la ubicación: $e');
    }
  }

  Future<void> _init() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final currentPosition = await _determinePosition();
    User? user = _auth.currentUser;
    if (user != null) {
      if (currentPosition != null) {
        updateLocation(currentPosition.latitude, currentPosition.longitude);
      } else {
        print('No se pudo obtener la posición actual.');
      }
    }
  }

  void _startPeriodicInit() {
    location.onLocationChanged.listen((LocationData currentLocation) {
      _init();
    });
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    print(user);
    _startPeriodicInit();
    return const MaterialApp(
      home: LoginScreen()
    );
  }
}