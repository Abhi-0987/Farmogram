import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmogram/screens/home_screen.dart';
import 'package:farmogram/screens/insect_result.dart';
import 'package:farmogram/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

class InsectFind extends StatefulWidget {
  const InsectFind({super.key});

  @override
  State<InsectFind> createState() => _InsectFindState();
}

class _InsectFindState extends State<InsectFind> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final translator = GoogleTranslator();
  String _insect = 'Error';
  String _probability = '404';
  final Map<String, String> translations = {
    'appname': 'Farmogram',
    'welcomeMessage': 'Welcome to Farmogram!',
    'footerText': 'Thank you for using our app.',
    'tab1': 'Crops',
    'tab2': 'Trending',
    'tab3': 'Marketplace'
  };
  final Map<String, String> textsToTranslate = {
    'appname': 'Farmogram',
    'welcomeMessage': 'Welcome to Farmogram!',
    'footerText': 'Thank you for using our app.',
    'tab1': 'Crops',
    'tab2': 'Trending',
    'tab3': 'Marketplace'
  };
  final List<MenuItem> menuItems = [
    MenuItem(text: 'Option 1', icon: Icons.home),
    MenuItem(text: 'Option 2', icon: Icons.settings),
    MenuItem(text: 'Logout', icon: Icons.logout),
  ];

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _deleteImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _translateTexts();
  }

  Future<void> _translateTexts() async {
    for (var entry in textsToTranslate.entries) {
      try {
        final translation =
            await translator.translate(entry.value, to: MainScreen.myLang);
        if (mounted) {
          setState(() {
            translations[entry.key] = translation.text;
          });
        }
      } catch (e) {
        // Handle error (showing a snackbar as an example)
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error during translation: $e')),
          );
        }
      }
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      Fluttertoast.showToast(msg: "Please select an image first.");
      return;
    }

    // Convert image to base64
    final bytes = await _selectedImage!.readAsBytes();
    String base64Image = base64Encode(bytes);
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final double lat = userDoc.data()?['selectedLat'];
    final double lng = userDoc.data()?['selectedLng'];

    // Prepare the request data
    const String apiKey =
        'AMp7M7xldf5cMhwzwzOv01YRKhOc9LiEeXJEL85oayqsMlcv6J'; // Replace with your actual API key
    final Map<String, dynamic> requestData = {
      "images": ["data:image/jpeg;base64,$base64Image"],
      "latitude": lat,
      "longitude": lng,
      "similar_images": true,
    };

    // Send the POST request
    final response = await http.post(
      Uri.parse('https://insect.kindwise.com/api/v1/identification'),
      headers: {
        'Api-Key': apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Parse the response
      final responseData = jsonDecode(response.body);
      Fluttertoast.showToast(msg: "Images uploaded successfully!");

      // Access the results
      var result = responseData['result'];
      print(result);

      // If there are disease suggestions
      if (result['classification'] != null) {
        var firstSuggestion = result['classification']['suggestions'][0];

        setState(() {
          _insect = firstSuggestion['name'];
          _probability = (firstSuggestion['probability'] * 100).toString();
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Failed to upload images.");
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff1A5319),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        bottomOpacity: 0,
        backgroundColor: const Color(0xff0A2A10),
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the color of the back button to white
        ),
        title: Text(
          translations['appname']!,
          style: TextStyle(fontSize: width * 0.07, color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0A2A10), Color(0xff1A5319)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Click or Pick the image of the plant effected by the disease',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _selectedImage == null
                ? const Text(
                    'No image selected',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                : Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            _selectedImage!,
                            height: height * 0.4,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton.icon(
                        onPressed: _deleteImage,
                        icon: const Icon(Icons.delete, color: Colors.red),
                        label: const Text(
                          'Delete Image',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 10),
            if (_selectedImage != null)
              _buildRoundedButton(
                icon: Icons.upload,
                label: 'Get Info',
                onPressed: () {
                  _uploadImage().then((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InsectResult(
                          selectedImage: _selectedImage!,
                          diseaseName: _insect,
                          accuracy: _probability,
                        ),
                      ),
                    );
                  });
                },
                backgroundColor: const Color(0xff80AF81),
                textColor: Colors.black,
              ),
            if (_selectedImage == null)
              _buildRoundedButton(
                icon: Icons.camera_alt,
                label: 'Pick from Camera',
                onPressed: () => _pickImage(ImageSource.camera),
              ),
            if (_selectedImage == null)
              _buildRoundedButton(
                icon: Icons.photo,
                label: 'Pick from Gallery',
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color backgroundColor = Colors.white,
    Color textColor = const Color(0xff1A5319),
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: textColor),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 5,
        padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
