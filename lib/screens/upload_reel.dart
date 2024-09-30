import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  _UploadVideoScreenState createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  File? _videoFile;
  bool _isUploading = false;
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadVideo() async {
    if (_videoFile == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a video and provide a description.')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final userId =
          FirebaseAuth.instance.currentUser!.uid; // Replace with actual user ID
      final videoId = FirebaseFirestore.instance.collection('videos').doc().id;
      final storageRef =
          FirebaseStorage.instance.ref().child('videos/$videoId.mp4');
      await storageRef.putFile(_videoFile!);
      final videoUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance.collection('videos').doc(videoId).set({
        'userId': userId,
        'videoUrl': videoUrl,
        'description': _descriptionController.text,
        'createdAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(
              content: Text('Video uploaded successfully!'),
              duration: Duration(
                  seconds:
                      2), // Set the duration for how long the SnackBar should be shown
            ),
          )
          .closed
          .then((value) {
        Navigator.pop(context);
      });
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload video: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Video'),
        backgroundColor: const Color(0xff1A5319), // Dark green theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickVideo,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xff1A5319), width: 2),
                ),
                child: _videoFile == null
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.video_library,
                                color: Color(0xff1A5319), size: 50),
                            SizedBox(height: 10),
                            Text('Tap to select a video',
                                style: TextStyle(color: Color(0xff1A5319))),
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          const Center(
                            child: Icon(Icons.play_circle_fill,
                                color: Color(0xff1A5319), size: 50),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _videoFile = null;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: const TextStyle(color: Color(0xff1A5319)),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff1A5319)),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xff1A5319), width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            _isUploading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _uploadVideo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xff1A5319), // Dark green theme
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle:
                          const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    child: const Center(
                        child: Text(
                      'Upload Video',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
          ],
        ),
      ),
    );
  }
}
