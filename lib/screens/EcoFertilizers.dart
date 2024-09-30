import 'package:flutter/material.dart';

class EcoFertilizersScreen extends StatelessWidget {
  final List<Map<String, String>> fertilizers = [
    {
      'title': 'Organic Fertilizers',
      'image':
          'https://thumbs.dreamstime.com/b/hands-holding-soil-organic-fertilizer-56483705.jpg',
      'description':
          'Compost, Manure, and Green Manure improve soil structure, increase microbial activity, and reduce nutrient runoff.'
    },
    {
      'title': 'Biofertilizers',
      'image':
          'https://www.shutterstock.com/image-photo/how-use-organic-fertilizer-farming-600nw-1693051096.jpg', // replace with real URLs
      'description':
          'Nitrogen-Fixing Bacteria, Mycorrhizal Fungi, and Beneficial Microorganisms enhance nutrient uptake and promote sustainable agriculture.'
    },
    {
      'title': 'Slow-Release Fertilizers',
      'image':
          'https://www.shutterstock.com/image-photo/male-hand-holding-black-color-260nw-2017705610.jpg', // replace with real URLs
      'description':
          'Organic and Polymer-Coated Fertilizers reduce nutrient leaching and provide a steady supply of nutrients.'
    },
    {
      'title': 'Mineral-Based Organic Fertilizers',
      'image':
          'https://www.shutterstock.com/image-photo/fertilizer-young-cucumbers-woman-pours-260nw-2427318733.jpg', // replace with real URLs
      'description':
          'Rock Phosphate, Greensand, and Kelp Meal improve soil fertility and moisture retention.'
    },
    {
      'title': 'Plant-Based Fertilizers',
      'image':
          'https://media.istockphoto.com/id/687716000/photo/a-female-old-hand-on-soil-earth-close-up-concept-of-old-age-youth-life-health-nature.jpg?s=612x612&w=0&k=20&c=iJn3br3Y-HCrDSMYpQE6PfmO7yz511HwcYVZk3vtEm8=',
      'description':
          'Alfalfa Meal, Soybean Meal, and Seaweed Extracts provide balanced nutrients and improve soil health.'
    },
    {
      'title': 'Green Chemistry Fertilizers',
      'image':
          'https://media.istockphoto.com/id/1249522339/photo/tractor-spray-fertilizer-on-green-field.jpg?s=612x612&w=0&k=20&c=8tyljgHGgTAxrqKnpgsZVWsD-A2tsMRPFaqcErgV62o=', // replace with real URLs
      'description':
          'Biodegradable Polymers and Organic Chelates enhance nutrient efficiency and reduce environmental impact.'
    },
  ];

  EcoFertilizersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6EFD8),
      appBar: AppBar(
        shadowColor: const Color(0xff80AF81),
        surfaceTintColor: const Color(0xff80AF81),
        backgroundColor: const Color(0xff80AF81),
        title: const Text(
          'Eco Fertilizers',
        ),
      ),
      body: ListView.builder(
        itemCount: fertilizers.length,
        itemBuilder: (context, index) {
          final fertilizer = fertilizers[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  fertilizer['image']!,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    fertilizer['title']!,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    fertilizer['description']!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
