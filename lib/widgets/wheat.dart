import 'package:flutter/material.dart';

class wheatScreen extends StatelessWidget {
  const wheatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildWeekContainer(
                'Week 1: Land Preparation',
                '',
                'Primary Tillage, Incorporate Organic Matter, Level the Field',
                'https://www.shutterstock.com/shutterstock/videos/1025545103/thumb/8.jpg?ip=x480'),
            buildWeekContainer(
                'Week 2: Seed Selection and Sowing',
                '',
                'Select High-Quality Seeds, Seed Treatment, Sowing, Fertilizer Application',
                'https://media.istockphoto.com/id/89280158/photo/sowing-wheat.jpg?s=612x612&w=0&k=20&c=o8NoRXHDgfYNUID89GorQ3dKDIpUK5lggkfU9-G620Y='),
            buildWeekContainer(
                'Week 3-4: Germination and Early Growth',
                '',
                'Irrigation Management, Weed Management, Pest Monitoring',
                'https://agribotix.com/wp-content/uploads/2024/03/how-long-does-it-take-wheat-to-germinate.jpg'),
            buildWeekContainer(
                'Week 5-6: Tillering Stage',
                '',
                'Second Irrigation, Top Dressing with Nitrogen, Weed Control',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNIRtBQhOfXeA93UypT7W5KAE0-_QW2NKfig&s'),
            buildWeekContainer(
                'Week 7-9: Active Tillering and Vegetative Growth',
                '',
                'Irrigation Management, Fertilizer Management, Pest and Disease Monitoring',
                'https://www.powerag.com/wp-content/uploads/2019/03/DSCF0006b.jpg'),
            buildWeekContainer(
                'Week 10-11: Jointing Stage',
                '',
                'Third Irrigation, Pest and Disease Control, Foliar Feeding',
                'https://i.postimg.cc/rsrQgRky/Screenshot-2024-09-06-00-05-08-277-com-peat-Garten-Bank-edit.jpg'),
            buildWeekContainer(
                'Week 12-13: Booting Stage',
                '',
                'Irrigation Management, Fertilizer Application, Monitor for Diseases',
                'https://i.postimg.cc/bYmyjGkV/Screenshot-2024-09-06-00-12-55-708-com-peat-Garten-Bank-edit.jpg'),
            buildWeekContainer(
                'Week 14-15: Heading and Flowering Stage',
                '',
                'Maintain Optimal Moisture, Pest and Disease Control, Avoid Water Stress',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOXElfYh26Tx5kmVCx5hxujCvX6AtSR1Aetw&s'),
            buildWeekContainer(
                'Week 16-17: Grain Filling and Dough Stage',
                '',
                'Irrigation Management, Monitor for Lodging, Final Pest Check',
                'https://res.cloudinary.com/active-agriscience/images/w_1920,h_1281,c_scale/f_webp,q_auto/v1643069469/grainfilling-wheat/grainfilling-wheat.jpg?_i=AA'),
            buildWeekContainer(
                'Week 18-20: Maturity and Harvesting',
                '',
                'Harvest Timing, Threshing and Drying, Post-Harvest Management',
                'https://as2.ftcdn.net/v2/jpg/03/55/24/23/1000_F_355242391_MQT5cutGR5H9WMyvZEHwkWiAnIL2ap7m.jpg'),
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
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Add functionality for 'Read more' button
              },
              child: Text(
                'Read more',
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
