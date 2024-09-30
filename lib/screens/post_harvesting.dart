import 'package:flutter/material.dart';

class PostHarvesting extends StatefulWidget {
  const PostHarvesting({super.key});

  @override
  State<PostHarvesting> createState() => _PostHarvestingState();
}

class _PostHarvestingState extends State<PostHarvesting> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Post-Harvesting Issues'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Storage and Transportation Issues",
                      style: TextStyle(
                        fontSize: width * 0.053,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: const [
                          MCard(
                            imagePath:
                                'https://www.rts.com/wp-content/uploads/2020/03/commercial-composting-feature-image-scaled-e1644274179312.jpg',
                            title: ' Perishability and Spoilage',
                            description:
                                'Many agricultural products are perishable and have a limited shelf life. Without proper storage and quick transportation, these products can spoil before reaching the market',
                          ),
                          MCard(
                            imagePath:
                                'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/0a49d82a-70d2-4115-baf1-0988a6d44bd6/afaa000d-103d-4ac9-bf42-bae3bc2854c3.png',
                            title: 'Inadequate Infrastructure',
                            description:
                                'Poor road conditions, lack of storage facilities, and insufficient transportation options hinder efficient movement and storage of agricultural products.',
                          ),
                          MCard(
                            imagePath:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-7R7U-sYNaO3KoK_1P2fPooL0vbDoRbt5piK9TddoMzJGXkfn',
                            title: 'Cost and Economic Factors',
                            description:
                                'The expenses associated with proper storage and transportation can be prohibitively high for small and medium-scale farmers.',
                          ),
                          MCard(
                            imagePath:
                                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQcpZQofkcGQpq5Rkpx_05FEKeTkeIg3-NPGzu7RCHs9uoxVZ1M',
                            title: 'Lack of Knowledge and Technology',
                            description:
                                'Farmers may lack access to information about best practices in storage and transportation, as well as the technology to implement these practices',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Market Access and Financial Issues",
                      style: TextStyle(
                        fontSize: width * 0.053,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: const [
                          MCard(
                            imagePath:
                                'https://img.freepik.com/free-vector/flat-design-bankruptcy-financial-recession_23-2148497987.jpg',
                            title: 'Price Volatility and Market Uncertainty',
                            description:
                                'General issue: Farmers often face unpredictable and fluctuating prices for their produce, making it difficult to plan and ensure stable income.',
                          ),
                          MCard(
                            imagePath:
                                'https://img.freepik.com/free-vector/flat-finance-concept-with-cute-style_23-2147677390.jpg',
                            title:
                                'Limited Access to Formal Financial Services',
                            description:
                                'General issue: Many farmers, especially smallholders, struggle to access formal banking services, credit, and insurance products.',
                          ),
                          MCard(
                            imagePath:
                                'https://img.freepik.com/free-vector/hand-drawn-international-trade_23-2149175321.jpg',
                            title:
                                ' Market Intermediaries and Value Chain Inefficiencies',
                            description:
                                'General issue: The presence of multiple intermediaries in the agricultural value chain often reduces farmers profit margins and market access.',
                          ),
                          MCard(
                            imagePath:
                                'https://static.vecteezy.com/system/resources/previews/000/478/777/non_2x/vector-agricultural-machines-isometric-banner-set.jpg',
                            title: ' Infrastructure and Logistical Challenges',
                            description:
                                'General issue: Poor infrastructure and logistical support hinder farmers ability to access broader markets and obtain fair prices for their produce.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      " Processing and Value Addition Issues",
                      style: TextStyle(
                        fontSize: width * 0.053,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: const [
                          MCard(
                            imagePath:
                                'https://img.etimg.com/thumb/width-1600,height-900,imgsize-106746,resizemode-75,msid-92194993/small-biz/sme-sector/the-fate-of-the-10-minute-delivery-services-is-tied-to-india-providing-a-cooler-solution.jpg',
                            title:
                                'Lack of Infrastructure and Storage Facilities',
                            description:
                                'General issue: Many farmers, especially smallholders, lack access to proper storage and processing facilities. This limits their ability to store produce for longer periods or process it into value-added products.',
                          ),
                          MCard(
                            imagePath:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkR8EW_L476SUJSiRsPwJ3jFRpZOF088m5yXCSTQuRBGudNCt5',
                            title: 'Limited Access to Technology and Knowledge',
                            description:
                                'General issue: Farmers often lack access to modern processing technologies and the knowledge to effectively use them for value addition.',
                          ),
                          MCard(
                            imagePath:
                                'https://blogmedia.testbook.com/blog/wp-content/uploads/2024/07/asymmetric-information-9ccd1416.png',
                            title: 'Market Access and Information Asymmetry',
                            description:
                                'General issue: Investing in processing and value addition requires capital, which is often difficult for farmers to access. Additionally, venturing into processing introduces new risks that farmers may struggle to manage.',
                          ),
                          MCard(
                            imagePath:
                                'https://img.freepik.com/premium-vector/risk-minimization-concept-outlines-strategic-financial-analysis-investment-uncertainty-reduction_277904-26197.jpg',
                            title: 'Financial Constraints and Risk Management',
                            description:
                                'General issue: Investing in processing and value addition requires capital, which is often difficult for farmers to access. Additionally, venturing into processing introduces new risks that farmers may struggle to manage.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Pest, Disease, and Environmental Issues",
                      style: TextStyle(
                        fontSize: width * 0.053,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.35,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: const [
                          MCard(
                            imagePath:
                                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQBV8taqzYqEcppQWDLiyHJNFPPfxCwRjkGl-vxPxXOxBxLCVYY',
                            title: 'Citrus Greening Disease (Huanglongbing)',
                            description:
                                'Citrus greening is a devastating bacterial disease affecting citrus trees worldwide.',
                          ),
                          MCard(
                            imagePath:
                                'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRMQ_1TFg_oltQ1e86p_1loM_GCWe5NjqPHL329VhoI-WmxI_Zm',
                            title: 'Fall Armyworm (Spodoptera frugiperda)',
                            description:
                                'The fall armyworm is a voracious pest causing extensive damage to crops across the Americas, Africa, and Asia.',
                          ),
                          MCard(
                            imagePath:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7TRSG8sKRU30FwaOqYpjZwYrtAOCy2guExLOEPdvEONnxxQ-q',
                            title: 'Soil Salinization',
                            description:
                                'Soil salinization is an environmental issue causing significant agricultural productivity losses worldwide.',
                          ),
                          MCard(
                            imagePath:
                                'https://4.imimg.com/data4/SM/IT/MY-925184/wheat-testing-500x500.jpg',
                            title: 'Fusarium Head Blight (FHB) in Wheat',
                            description:
                                'Fusarium Head Blight, also known as scab, is a fungal disease severely impacting wheat and other small grain crops.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.35,
              width: width * 0.96,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        offset: const Offset(1, 2),
                        color: Colors.black.withOpacity(0.4))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: Text(
                      "Ask for help",
                      style: TextStyle(
                        fontSize: width * 0.053,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: Text(
                      "Share yout issue with the community so that someone can help you out.",
                      style: TextStyle(
                        fontSize: width * 0.04,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                    child: Container(
                      height: height * 0.15, // height of the container
                      width: width * 0.92, // width of the container
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(
                            0.1), // black color with lesser opacity
                        borderRadius: BorderRadius.circular(
                            8), // optional: rounded corners
                      ),
                      child: const TextField(
                        maxLines: null, // allows multiline input

                        decoration: InputDecoration(
                          hintText: 'Enter your text here',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          border: InputBorder.none, // remove default border
                        ),
                        style: TextStyle(
                            color: Colors.black), // optional: text color
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 2, 111, 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.25, vertical: height * 0.013),
                      ),
                      child: const Text(
                        'Submit query',
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
            SizedBox(
              height: height * 0.02,
            )
          ],
        ),
      ),
    );
  }
}

class MCard extends StatelessWidget {
  const MCard(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.description});
  final String imagePath;

  // const MCard({super.key, required this.imagePath});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          // width: width * 0.45,
          decoration: BoxDecoration(
              color: const Color(0xffD6EFD8),
              border: Border.all(color: Colors.black12.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(1, 2))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      height: height * 0.15,
                      width: width * 0.6,
                      child: Image.network(
                        imagePath,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return const Center(
                            child: Icon(Icons.error),
                          );
                        },
                      )),
                ),
                SizedBox(
                  width: width * 0.62,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: width * 0.05),
                  ),
                ),
                SizedBox(
                  width: width * 0.6,
                  child: Text(
                    description,
                    style: TextStyle(fontSize: width * 0.03),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: width * 0.02,
        )
      ],
    );
  }
}
