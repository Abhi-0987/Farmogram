import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: ProfessionalAdviceScreen()));
}

class ProfessionalAdviceScreen extends StatelessWidget {
  const ProfessionalAdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Professional Advice'),
        backgroundColor: const Color(0xFF2E865F),
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xFF1A1D23),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Professional Advice',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Start advice session logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF34C759),
                ),
                child: const Text('Start Advice Session'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
