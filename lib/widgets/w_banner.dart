import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmogram/models/weather_data.dart';
import 'package:farmogram/utils/weather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WBanner extends StatefulWidget {
  const WBanner({super.key});

  @override
  State<WBanner> createState() => _WBannerState();
}

class _WBannerState extends State<WBanner> {
  WeatherData weatherData = WeatherData();
  IconData getWeatherIcon(String iconId) {
    return weatherIcons[iconId] ??
        Icons
            .help_outline; // Default to a question mark if the iconId is not found
  }

  @override
  void initState() {
    super.initState();
    fetchWeather(); // Get the current location when the widget is initialized
  }

  Future<void> fetchWeather() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    final userLat = userDoc.data()?['selectedLat'];
    final userLng = userDoc.data()?['selectedLng'];

    final response = await http.get(
      Uri.parse(
          'https://api.agromonitoring.com/agro/1.0/weather?lat=$userLat&lon=$userLng&appid=dc4add5adcea15aade782cf3bf245428'),
    );

    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON
      if (mounted) {
        setState(() {
          weatherData = WeatherData.fromJson(jsonDecode(response.body));
        });
      }
    } else {
      // If the server does not return an OK response, throw an exception
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height * 0.26,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xff1A5319),
              Color(0xff173e16),
              Color(0xff0f2a0f),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        width: width * 0.6,
        child: weatherData.main == null
            ? Center(
                child: SizedBox(
                    height: height * 0.1,
                    width: width * 0.2,
                    child:
                        const CircularProgressIndicator(color: Colors.white)),
              )
            : Stack(
                children: [
                  Positioned(
                    top: -50,
                    right: -50,
                    child: Icon(
                      Icons.wb_sunny,
                      color: Colors.white.withOpacity(0.1),
                      size: 180,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              getWeatherIcon(weatherData.weather!.first.icon!),
                              color: Colors.yellowAccent,
                              size: 40,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              weatherData.weather!.first.main!,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            weatherData.main == null
                                ? const CircularProgressIndicator()
                                : Text(
                                    '${weatherData.main!.temp.toString()}\u00B0C',
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                            SizedBox(
                              width: width * 0.2,
                            ),
                            const Text(
                              'Humidity: ',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 243, 225, 225),
                              ),
                            ),
                            Text(
                              weatherData.main!.humidity.toString(),
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.wind_power,
                              color: Colors.blueAccent,
                              size: 24,
                            ),
                            SizedBox(
                              width: width * 0.05,
                            ),
                            const Text(
                              'Wind Speed: ',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              weatherData.wind!.speed.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
