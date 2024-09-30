import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ResultScreen extends StatefulWidget {
  final File selectedImage;
  final String diseaseName;
  final String accuracy;

  const ResultScreen({
    super.key,
    required this.selectedImage,
    required this.diseaseName,
    required this.accuracy,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final apiKey = 'AIzaSyDhfHcv_hTZwqM4fiE4-AjyyPCKBXCUFYc';

  late final GenerativeModel _model;

  late final ChatSession _chat;
  String cure = 'Loading..!!!';

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );
    _chat = _model.startChat();
    _sendChatMessage('Find the cure of ${widget.diseaseName}');
  }

  Future<void> _sendChatMessage(String message) async {
    try {
      final response = await _chat.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      setState(() {
        cure = text!;
      });

      if (text == null) {
        _showError('Empty response.');
        return;
      }
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  Future<void> _launchInBrowser() async {
    Uri url =
        Uri.parse('https://www.google.com/search?q=${widget.diseaseName}');
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search Results',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xff1A5319),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the color of the back button to white
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1A5319), Color(0xff0A2A10)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(
                  widget.selectedImage,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Disease Name: ${widget.diseaseName}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Accuracy: ${widget.accuracy}%',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffD6EFD8),
                      border:
                          Border.all(color: Colors.black12.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(1, 2))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MarkdownBody(
                      data: cure,
                      styleSheet: MarkdownStyleSheet(
                        h1: const TextStyle(
                            fontSize: 24.0, color: Colors.black), // Header 1
                        h2: const TextStyle(
                            fontSize: 20.0, color: Colors.black), // Header 2
                        p: const TextStyle(
                            fontSize: 16.0, color: Colors.black), // Paragraph
                      ),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              _buildRoundedButton(
                icon: Icons.search,
                label: 'Search for Cure',
                onPressed: () async {
                  _launchInBrowser();
                },
                backgroundColor: Colors.white,
                textColor: const Color(0xff1A5319),
              ),
            ],
          ),
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
