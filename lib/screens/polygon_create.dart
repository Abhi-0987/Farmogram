import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmogram/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';

class CreatePolygon extends StatefulWidget {
  const CreatePolygon({super.key});

  @override
  State<CreatePolygon> createState() => _CreatePolygonState();
}

class _CreatePolygonState extends State<CreatePolygon> {
  LatLng? _currentLocation; // To store the current location
  LatLng? _selectedLocation; // To store the selected location
  bool _isLocationLocked = false; // To lock/unlock the location

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Get the current location when the widget is initialized
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();
    LocationData? currentLocation;

    try {
      currentLocation = await location.getLocation();
      setState(() {
        _currentLocation =
            LatLng(currentLocation!.latitude!, currentLocation.longitude!);
        _selectedLocation =
            _currentLocation; // Set the initial selected location
      });
    } catch (e) {
      print("Could not get the current location: $e");
    }
  }

  void _toggleLock() {
    setState(() {
      _isLocationLocked = !_isLocationLocked;
    });
  }

  void _removeMarker() {
    setState(() {
      _selectedLocation = null;
      _isLocationLocked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select and Confirm Location'),
        actions: [
          if (_selectedLocation != null)
            IconButton(
              icon: Icon(_isLocationLocked ? Icons.lock : Icons.lock_open),
              onPressed: _toggleLock,
            ),
          if (_selectedLocation != null && _isLocationLocked)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _removeMarker,
            ),
        ],
      ),
      body: _currentLocation == null
          ? const Center(
              child: CircularProgressIndicator()) // Show loading spinner
          : Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter:
                        _currentLocation!, // Set the center to the current location
                    initialZoom: 15.0, // Set an appropriate zoom level
                    onTap: (tapPosition, point) {
                      if (!_isLocationLocked) {
                        setState(() {
                          _selectedLocation = point; // Update selected location
                        });
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    if (_selectedLocation != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: _selectedLocation!,
                            child: Icon(
                              Icons.location_on,
                              color:
                                  _isLocationLocked ? Colors.red : Colors.blue,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                Positioned(
                  left: width * 0.7,
                  top: height * 0.73,
                  child: GestureDetector(
                    onTap: () async {
                      if (_isLocationLocked) {
                        await createPolygon(
                            getSquarePolygon(_selectedLocation!, 1000));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Location Not Locked"),
                              content: const Text(
                                  "Please lock the location before saving."),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.05),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
    );
  }

  List<LatLng> getSquarePolygon(LatLng center, double distanceInMeters) {
    const Distance distance = Distance();

    // Calculate the four corners of the square
    LatLng northWest = distance.offset(center, distanceInMeters * 1.414, 315);
    LatLng northEast = distance.offset(center, distanceInMeters * 1.414, 45);
    LatLng southEast = distance.offset(center, distanceInMeters * 1.414, 135);
    LatLng southWest = distance.offset(center, distanceInMeters * 1.414, 225);

    // Round the coordinates to 6 decimal places to reduce the payload size
    return [
      _roundLatLng(northWest),
      _roundLatLng(northEast),
      _roundLatLng(southEast),
      _roundLatLng(southWest),
      _roundLatLng(northWest),
    ];
  }

  LatLng _roundLatLng(LatLng point) {
    double roundDouble(double value, int places) {
      num mod = pow(10.0, places);
      return ((value * mod).round().toDouble() / mod);
    }

    return LatLng(
      roundDouble(point.latitude, 6), // Round latitude
      roundDouble(point.longitude, 6), // Round longitude
    );
  }

  Future<void> createPolygon(List<LatLng> points) async {
    // Convert LatLng points to the required GeoJSON format
    final coordinates =
        points.map((point) => [point.longitude, point.latitude]).toList();

    // Agromonitoring API URL with your appid
    const url =
        'https://api.agromonitoring.com/agro/1.0/polygons?appid=1e9b73bd6c08d6196bd7753049bbb670';

    // Retrieve the current Firebase user
    final User? user = FirebaseAuth.instance.currentUser;
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    final String? username = userDoc.data()?['name'];

    try {
      // Make the POST request to Agromonitoring API
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": username ?? "Default Name", // Fallback if username is null
          "geo_json": {
            "type": "Feature",
            "properties": {},
            "geometry": {
              "type": "Polygon",
              "coordinates": [coordinates], // Convert to the required format
            }
          }
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Decode the response body
        final responseData = jsonDecode(response.body);
        final polygonId = responseData['id'];

        // Store the polygon ID in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'polygonId': polygonId,
          'selectedLat': _selectedLocation!.latitude,
          'selectedLng': _selectedLocation!.longitude
        });

        // Show success dialog
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Success"),
                content:
                    const Text("Your location has been saved successfully."),
                actions: <Widget>[
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const MainScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        // If response status is not 200/201, show error
        print('Error response: ${response.statusCode}');
        _showErrorDialog(context, 'Error: ${response.statusCode}',
            'Failed to create polygon. Please check the API or try again later.');
      }
    } catch (e) {
      print('Exception caught: $e');
      _showErrorDialog(
        context,
        'Request Failed',
        'Please check your internet connection or try again later.',
      );
    }
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
