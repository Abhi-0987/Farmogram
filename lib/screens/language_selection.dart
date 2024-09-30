import 'package:farmogram/screens/polygon_create.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedLanguage;
  final Map<String, String> _languages = {
    'English': 'en',
    'हिन्दी': 'hi', // Hindi
    'తెలుగు': 'te', // Telugu
    'தமிழ்': 'ta', // Tamil
    'ಕನ್ನಡ': 'kn', // Kannada
    'मराठी': 'mr', // Marathi
    'বাংলা': 'bn', // Bengali
  };

  Future<void> _saveLanguagePreference(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferred_language', languageCode);
  }

  void _onLanguageSelected(String language, String code) {
    setState(() {
      _selectedLanguage = code;
    });
  }

  void _onAcceptPressed() {
    if (_selectedLanguage != null) {
      _saveLanguagePreference(_selectedLanguage!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Language preference saved!')),
      );

      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const CreatePolygon(),
        ),
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a language.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
        backgroundColor: const Color(0xff1A5319), // Dark green theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  String language = _languages.keys.elementAt(index);
                  String code = _languages.values.elementAt(index);
                  return Card(
                    color: _selectedLanguage == code
                        ? const Color(0xffA9DFBF) // Highlight selected language
                        : Colors.white,
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        language,
                        style: const TextStyle(
                          color: Color(0xff1A5319),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      trailing: _selectedLanguage == code
                          ? const Icon(Icons.check_circle,
                              color: Color(0xff1A5319))
                          : const Icon(Icons.circle_outlined,
                              color: Color(0xff1A5319)),
                      onTap: () => _onLanguageSelected(language, code),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onAcceptPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1A5319), // Dark green theme
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child:
                  const Text('Accept', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
