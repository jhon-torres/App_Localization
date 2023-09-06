import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_am/screens/login_screen.dart';
import 'package:proyecto_am/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_am/utils/color_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {}; // Conjunto de marcadores
  List<Map<String, dynamic>> userList = [];
  Marker? _firstMarker;  

  @override
  void initState() {
    super.initState();
    loadUsers();

    // Escuchar cambios en Firestore y actualizar los marcadores
    FirebaseFirestore.instance
        .collection('locations')
        .snapshots()
        .listen((snapshot) {
      loadUsers(); // Recargar los usuarios y actualizar los marcadores
    });
  }

  Future<void> loadUsers() async {
    final users =
        await getUsers(); // Obtener la lista de usuarios desde el servicio
    setState(() {
      userList = users; // Asignar la lista de usuarios
      _addMarkers(); // Agregar marcadores al mapa cuando se carguen los usuarios
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _addMarkers() {
    userList.forEach((user) {
      final marker = Marker(
        markerId: MarkerId(user['name']),
        position: LatLng(user['latitud'].toDouble(), user['longitud'].toDouble()),
        infoWindow: InfoWindow(title: user['name']),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // Personaliza
      );
      setState(() {
        _markers.add(marker);
        if (_firstMarker == null) {
          _firstMarker = marker;
          _setInitialCameraPosition(marker.position);
        }
      });
    });
  }

  void _setInitialCameraPosition(LatLng position) {
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLngZoom(
        position,
        15, // Ajusta este valor para establecer el nivel de zoom deseado
      ));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(       
        backgroundColor: hexStringToColor("32D9CB"),
        title: const Text("PRINCIPAL"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              });
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _firstMarker != null
            ? CameraPosition(
                target: _firstMarker!.position,
                zoom:
                    15, // Ajusta este valor para establecer el nivel de zoom deseado
              )
            : const CameraPosition(
                target: LatLng(-0.204742, -78.485126),
                zoom: 15,
              ),
        onMapCreated: _onMapCreated,
        markers: _markers, // Usar el conjunto de marcadores actual
      ),
    );
  }
}
