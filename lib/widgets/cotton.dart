import 'package:flutter/material.dart';

class CottonScreen extends StatelessWidget {
  const CottonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildWeekContainer(
              'Week 1-2: Land Preparation',
              '',
              'Primary Tillage',
              'https://thumbs.dreamstime.com/b/autumn-plowed-strip-land-preparing-winter-village-farm-61098476.jpg',
            ),
            buildWeekContainer(
              'Week 1-2: Land Preparation',
              '',
              'Secondary Tillage',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTq2obqjkwqxRefhKN045XjloUHeoXvvfof4g&s',
            ),
            buildWeekContainer(
              'Week 1-2: Land Preparation',
              '',
              'Add Organic Matter',
              'https://i0.wp.com/www.ecomena.org/wp-content/uploads/2014/01/composting-arabic.jpg?fit=500%2C375&ssl=1',
            ),
            buildWeekContainer(
                'Week 3: Seed Selection and Sowing',
                '',
                'Select High-Quality Seeds',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZ1yjvHieTt2FDg-Z44aWl7upavYcQyXoM5g&s'),
            buildWeekContainer(
              'Week 4-6: Germination and Early Seedling Stage',
              '',
              'Irrigation Management',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh-nDdkiZ9ZkUDJpvBIBZrso6nv4JSpVFCOw&s',
            ),
            buildWeekContainer(
              'Week 7-8: Vegetative Growth Stage',
              '',
              'Irrigation Schedule',
              'https://c8.alamy.com/comp/EA1YX0/agriculture-early-growth-cotton-plants-at-the-8-10-leaf-stage-growing-EA1YX0.jpg',
            ),
            buildWeekContainer(
              'Week 9-12: Square Formation Stage',
              '',
              'Weed Control',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQD1xMMSToBXd9EV43FTa5t4pmk_cmozpAPLA&s',
            ),
            buildWeekContainer(
                'Week 13-16: Flowering Stage',
                '',
                'Maintain Moisture Levels',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfttBLdgkr5nRigUuIDQpT_ynjEWJRBuY1vg&s'),
            buildWeekContainer(
                'Week 17-20: Ball Development Stage',
                '',
                'Irrigation Management',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfttBLdgkr5nRigUuIDQpT_ynjEWJRBuY1vg&s'),
            buildWeekContainer(
              'Week 21-24: Boll Maturation Stage',
              '',
              'Irrigation Reduction',
              'https://www.shutterstock.com/image-photo/open-cotton-harvest-stage-sunrise-600nw-1895411851.jpg',
            ),
            buildWeekContainer(
                'Week 21-24: Boll Maturation Stage',
                '',
                'Pest Control',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQule_Jqtq8vQ6y-FAOOrf2a6cW55ePVyXknA&s'),
            buildWeekContainer(
              'Week 25-28: Maturity and Harvesting Preparation',
              '',
              'Final Irrigation',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoTWzTZUDxVZYJljEX5rUUJi6I3bWczdivcDEagOD6jvVQ6-cjG9CftcedQSyxnf5CI6Q&usqp=CAU',
            ),
            buildWeekContainer(
              'Week 29-30: Harvesting',
              '',
              'Hand or Mechanical Harvesting',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb9Rsk3WNS_xzCRmBbUZTGB5QA3dysWtg6Yg&s',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWeekContainer(
      String week, String dateRange, String description, String imagePath) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              week,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              dateRange,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              width: 350,
              child: Image.network(imagePath, fit: BoxFit.cover, loadingBuilder:
                  (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Image has loaded completely
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              }),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
