import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmogram/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';

class AskScreen extends StatefulWidget {
  const AskScreen({super.key});

  @override
  State<AskScreen> createState() => _AskScreenState();
}

class _AskScreenState extends State<AskScreen> {
  final translator = GoogleTranslator();
  final _formKey = GlobalKey<FormState>();
  final _questionC = TextEditingController();
  final _descC = TextEditingController();
  File? _image;
  bool _isLoading = false;

  final Map<String, String> translations = {
    'appname': 'Ask Community',
    'image': 'Add image',
    'crop': 'Add crop',
    'msg':
        'Adding your crop data might increase the probability of getting the correct answer',
    'question': 'Your question to the community',
    'desc': 'Description of your problem',
    'queshint': "Add a question indicating what's wrong with your crop",
    'deschint':
        "Describe specialities such as change of the leaves, root color, bugs, tears... e.t.c",
    'buttonT': 'Send',
  };
  final Map<String, String> textsToTranslate = {
    'appname': 'Ask Community',
    'image': 'Add image',
    'crop': 'Add crop',
    'msg':
        'Adding your crop data might increase the probability of getting the correct answer',
    'question': 'Your question to the community',
    'desc': 'Description of your problem',
    'queshint': "Add a question indicating what's wrong with your crop",
    'deschint':
        "Describe specialities such as change of the leaves, root color, bugs, tears... e.t.c",
    'buttonT': 'Send',
  };

  @override
  void initState() {
    super.initState();
    _translateTexts();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<Map<String, String?>> fetchStateAndCountry(
      double latitude, double longitude) async {
    const apiKey =
        'bb7241ea267b4be8aaccf11f3df223da'; // Replace with your Geoapify API key
    final url =
        'https://api.geoapify.com/v1/geocode/reverse?lat=$latitude&lon=$longitude&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['features'] != null && data['features'].isNotEmpty) {
        final properties = data['features'][0]['properties'];
        final state = properties['state'] as String?;
        final country = properties['country'] as String?;
        return {'state': state, 'country': country};
      }
    } else {
      throw Exception('Failed to load location data');
    }

    return {'state': null, 'country': null};
  }

  Future<void> _createPost() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final double? userLat = userDoc.data()?['selectedLat'];
    final double? userLng = userDoc.data()?['selectedLng'];

    if (_formKey.currentState!.validate() && _image != null) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      try {
        // Upload the image to Firebase Storage
        String fileName = path.basename(_image!.path);
        Reference storageRef = FirebaseStorage.instance.ref().child(
            'post_images/${FirebaseAuth.instance.currentUser!.uid}/$fileName');
        UploadTask uploadTask = storageRef.putFile(_image!);
        TaskSnapshot snapshot = await uploadTask;
        String imageUrl = await snapshot.ref.getDownloadURL();

        Map<String, String?> locationDetails =
            await fetchStateAndCountry(userLat!, userLng!);

        // Save post details to Firestore

        DocumentReference postRef =
            FirebaseFirestore.instance.collection('posts').doc();

        Map<String, dynamic> postData = {
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'question': _questionC.text,
          'description': _descC.text,
          'imageUrl': imageUrl,
          'postedAt': Timestamp.now(),
          'state': locationDetails['state'],
          'postId': postRef.id, // Include the document ID in the data
        };
        await postRef.set(postData);

        // Get the postId of the newly created post
        String postId = postRef.id;

        // Update the user's document to add the new postId to the array of postIds
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'postIds': FieldValue.arrayUnion([postId]),
        });

        if (mounted) {
          setState(() {
            _isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Post created successfully!')),
          );

          Navigator.pop(context);
        }
      } catch (error) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create post: $error')),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please fill all fields and select an image')),
        );
      }
    }
  }

  Future<void> _translateTexts() async {
    for (var entry in textsToTranslate.entries) {
      try {
        final translation = await translator.translate(entry.value,
            from: 'en', to: MainScreen.myLang);
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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xffD6EFD8),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        bottomOpacity: 0,
        shadowColor: const Color(0xff80AF81),
        surfaceTintColor: const Color(0xff80AF81),
        backgroundColor: const Color(0xff80AF81),
        title: Text(
          translations['appname']!,
          style: TextStyle(fontSize: width * 0.07),
        ),
        toolbarHeight: height * 0.08,
        actions: [
          Icon(
            Icons.notifications,
            size: width * 0.07,
          ),
          PopupMenuButton<String>(
              onSelected: (String value) {
                // Handle the selected option
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You selected: $value'),
                  ),
                );
              },
              itemBuilder: (BuildContext context) {
                return {'Option 1', 'Option 2', 'Option 3'}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              icon: const Icon(Icons.more_horiz_outlined)),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: height * 0.8,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  if (_image != null)
                    Image.file(
                      _image!,
                      height: height * 0.15,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  if (_image == null)
                    GestureDetector(
                      onTap: () async {
                        await _pickImage();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff1A5319)),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.image_rounded),
                              Text(translations['image']!)
                            ],
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(translations['msg']!),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff1A5319)),
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Iconify(
                            GameIcons.plant_roots,
                          ),
                          Text(translations['crop']!)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    width: width * 0.9,
                    child: Text(
                      translations['question']!,
                      style: TextStyle(
                          fontSize: width * 0.045, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  TextFormField(
                    controller: _questionC,
                    maxLines:
                        null, // Allows the TextField to expand as needed for multiline input
                    maxLength: 100,
                    decoration: InputDecoration(
                      hintText: translations['queshint']!,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                            color: Color(0xff1A5319), width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    cursorColor: const Color(0xff1A5319), // Cursor color
                    style: const TextStyle(color: Colors.black), // Text color
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a question';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    width: width * 0.9,
                    child: Text(
                      translations['desc']!,
                      style: TextStyle(
                          fontSize: width * 0.045, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  TextFormField(
                    controller: _descC,
                    maxLines:
                        null, // Allows the TextField to expand as needed for multiline input
                    maxLength: 2000,
                    decoration: InputDecoration(
                      hintText: translations['deschint']!,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                            color: Color(0xff1A5319), width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    cursorColor: const Color(0xff1A5319), // Cursor color
                    style: const TextStyle(color: Colors.black), // Text color
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () => {_createPost()},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 1, 73, 23),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.25,
                                  vertical: height * 0.013),
                            ),
                            child: const Text(
                              'Send',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'josefin',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
