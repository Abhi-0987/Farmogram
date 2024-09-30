import 'package:flutter/material.dart';

class RiceScreen extends StatelessWidget {
  const RiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildWeekContainer(
                '5 weeks before seedling',
                '',
                'Choose a variety that fits your needs',
                'https://i.ibb.co/tK6QWj3/image.png' // Replace with your local asset path
                //  'https://i.ibb.co/tK6QWj3/image.png'

                ),
            buildWeekContainer('5 weeks before seedling', '', 'First plowing',
                'https://search-static.byjusweb.com/question-images/byjus/wikipedia/commons/b/b7/Ploughing_by_mini-tractor_1.jpg' // Replace with your local asset path

                ),
            buildWeekContainer(
                '4 weeks before seedling',
                '',
                'Select a good nursery site',
                'https://www.shutterstock.com/image-photo/rice-nursery-obtain-quality-seeds-260nw-2228337055.jpg' // Replace with your local asset path
                ),
            buildWeekContainer(
                '4 weeks before seedling',
                '',
                'Prepare a wet-bed nursery',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt5TDQIMQrWRG2l2cmCJgNK3v-_zlGQxiXRQ&s'),
            buildWeekContainer(
                '3 weeks before seedling',
                '',
                'Sowing in the nursery',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ19H6_bePZt1_CNWAIq3_5XXplVcASgCFj9Q&s'),
            buildWeekContainer(
              '3 weeks before seedling',
              '',
              'Prevention for weed growth',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdkM-zoXu88XbJlceUv6X9PeARhpSxEjAXdw&s', // Replace with your local asset path
            ),
            buildWeekContainer(
                '2 weeks before seedling',
                '',
                'Fertilize your nursery',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ6K0Vp-jqY2fHvJj89uho5_uOVdoUL4qfaw&s'),
            buildWeekContainer('1 weeks before seedling', '', 'Second plowing',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjMQ1rRdFS9l9FtnPXgRPWRJUmqKXbodE5NQ&s'),
            buildWeekContainer(
                '1 weeks before seedling',
                '',
                'Fertilization before transplanting',
                'https://cdn.mos.cms.futurecdn.net/cavecTi5Y38sEEnmpTYmFP.jpg'),
            buildWeekContainer(
                '1 weeks before seedling',
                '',
                'Leveling the paddy field',
                'https://live.staticflickr.com/39/109356725_5e68f782eb_b.jpg'),
            buildWeekContainer(
                'week 1',
                '',
                'Prevent and control yellow stem borer',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSb3j_EFFEqmwCz5GeKFzWhb5h9mdqSwNJUVQ&s'),
            buildWeekContainer(
                'Week 1',
                '',
                'Time to transplant your seedlings',
                'https://fordtractorphbade3.zapwp.com/q:i/r:0/wp:0/w:1/u:https://fordtractor.ph/wp-content/uploads/2022/03/A-guide-on-preparing-rice-seedlings-for-transplanting.jpg'),
            buildWeekContainer(
                'Week 1',
                '',
                'spray pre-emergence herbicides in rice',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCpcqpDzXuJgqUVDkRhdwyMs3BncInD09hgw&s'),
            buildWeekContainer(
                'week 1',
                '',
                'Irrigation during the critical stages',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdvCLc5cmu1utRvDmvZMmATMPGF-s4GkdtFOaCemgdMrECD3cNUG2LqKlw6cA4JYqCqZk&usqp=CAU'),
            buildWeekContainer(
                'Week 3',
                '',
                'Weeding- Manual and mechanical weed control',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHsfDd-T1AeT4VS89603qwLxT-CUdoJlU4PQ&s'),
            buildWeekContainer(
              'Week 1-3',
              '',
              'Monitor your field yellow stem borer may appear in crop',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrLSRT4FtB7zjCQKR_d5kJFHo_fgGaXd-OtQ&s', // Replace with your local asset path
            ),
            buildWeekContainer('Week 4', '', 'Weed control: herbicide usage',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8Zw6Cu_6bFPsz5d3cqBKRW-GHre5pUJ39Hg&s'),
            buildWeekContainer('Week 4', '', 'Fertilization at tillering stage',
                'https://www.shutterstock.com/image-photo/farmer-apply-fertilizer-onto-rice-260nw-5203225.jpg'),
            buildWeekContainer(
                'Week 4-10',
                '',
                'Monitor your field - Sheath Rot of Rice, Asian Rice Gall Midge, Stem Rot of Rice, Rice Bug, Rice Sheath Blight, Brown Spot of Rice, Rice Leafroller',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRV2pZ8OjU4egndH9iEjR4tzQJHwU6LSJm-0Q&s'),
            buildWeekContainer('Week 11', '', 'Manage your water wisely',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWyDjybSrLF2Bhzo-rnkE2gu4BMWvh6_weIw&s'),
            buildWeekContainer(
                'Week 11-14',
                '',
                'Monitor your field - Brown Planthopper, Rice Panicle Mite',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRF4ZiCzDwhXtjhsxxPNvG_jDZX88tNUUaCtQ&s'),
            buildWeekContainer(
              'Week 15',
              '',
              'Monitor fields frequently',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBKdlq9-8ISUshTP_zJ0ZgtgvQkmkXZuRXrg&s', // Replace with your local asset path
            ),
            buildWeekContainer('Week 11', '', 'Monitor your field - False Smut',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzNCEB3X3IlARLz5Hw1UamID8GvhPzU-go6Q&s'),
            buildWeekContainer('Week 18', '', 'Choosing when to harvest',
                'https://images.saymedia-content.com/.image/ar_4:3%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:eco%2Cw_1200/MTkwNzQ3NzAyMzQ1MTQ4MDUw/how-do-you-pick-rice.jpg'),
            buildWeekContainer('Week 19', '', 'Threshing rice after harvest',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRN6LJbbdkDvQVijdS4k3igCEX51KGmLM0YFw&s'),
            buildWeekContainer('Week 20', '', 'Drying your rice crop',
                'https://www.nextechagrisolutions.com/blog/wp-content/uploads/2017/01/Paddy-Drying-Process-1200x800.jpg'),
            buildWeekContainer('Week 21', '', 'Appropriate storage conditions',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGyjhNXWKGF_FGdRnAA3R_sd-G4urkaHELTw&s')
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
