import 'package:flutter/material.dart';

class PreHarvest extends StatefulWidget {
  const PreHarvest({super.key});

  @override
  State<PreHarvest> createState() => _PreHarvestState();
}

class _PreHarvestState extends State<PreHarvest> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pre-Harvesting Issues'),
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
                      "Farm Related Issues",
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
                            title: ' Climate Change and Weather Variability',
                            imagePath:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTA8o2dnD-1Bg_cexeV5VMJwaNyneU83a00BWFexWiyEX3bOd22',
                            description:
                                'Climate change poses a significant challenge to agriculture by causing unpredictable weather patterns such as droughts, floods, unseasonal rains, and extreme temperatures',
                          ),
                          MCard(
                            title: 'Pest and Disease Infestations',
                            imagePath:
                                'https://www.shutterstock.com/image-photo/plant-disease-symptom-on-wild-260nw-1809969313.jpg',
                            description:
                                'Pests and diseases are a persistent threat to crop production, causing substantial yield losses each year.',
                          ),
                          MCard(
                            title: 'Water Management and Scarcity',
                            imagePath:
                                'https://housing.com/news/wp-content/uploads/2023/11/What-is-Chahi-land-t-1.jpg',
                            description:
                                'Efficient water management is a critical issue in agriculture, especially in regions prone to water scarcity or erratic rainfall.',
                          ),
                          MCard(
                            title: ' Market Access and Fair Pricing',
                            imagePath:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKhclzNk2qWhbDJkBHbpOsdnwViCwEczaISsBK0sH3_5gYjE57',
                            description:
                                'Access to markets and fair pricing are critical for the economic sustainability of farmers, particularly smallholders. ',
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
                      "Financial Related Issues",
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
                        //   children: const [MCard(), MCard(), MCard(), MCard()],
                        children: const [
                          MCard(
                            title: ' Limited Access to Credit and Financing',
                            imagePath:
                                'https://kisanvedika.bighaat.com/wp-content/uploads/2024/04/26645.jpg',
                            description:
                                'Many small-scale and marginal farmers struggle to access credit due to lack of collateral, limited credit history, and high-interest rates.',
                          ),
                          MCard(
                            title: 'Inadequate Crop Insurance Coverage',
                            imagePath:
                                'https://img.freepik.com/premium-photo/young-indian-agronomist-financier-showing-zero-percent-sign-symbol-agriculture-field_54391-5306.jpg',
                            description:
                                ' Crop insurance schemes are often underdeveloped, with low penetration among smallholder farmers',
                          ),
                          MCard(
                            title: 'Dependency on Informal Moneylenders',
                            imagePath:
                                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQ5vNsPFyOUlwQJ1GLF7dCeImej7cMHRl3zopMqQfwf5KHM3biM',
                            description:
                                ' In the absence of access to formal credit institutions, many farmers turn to informal moneylenders who charge exorbitant interest rates',
                          ),
                          MCard(
                            title: 'Market and Price Volatility',
                            imagePath:
                                'https://www.benzinga.com/files/images/story/2024/Adani-Wilmar-manages-to-rise-despite-oth_0.jpeg',
                            description:
                                ' Fluctuating prices of agricultural commodities in local and global markets create uncertainty for farmers. ',
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
                      "Technological Issues",
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
                        // children: const [MCard(), MCard(), MCard(), MCard()],
                        children: const [
                          MCard(
                            title:
                                ' Limited Access to Precision Agriculture Technologies',
                            imagePath:
                                'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRAZcrXB3ZP6g6SoAwUH6d6Tp-sBBvEJaUU-D1uzsv4h5VXUfrn',
                            description:
                                ' Precision agriculture involves using technologies such as GPS-guided equipment, drones, remote sensing, and IoT sensors to monitor and manage crops more efficiently. ',
                          ),
                          MCard(
                            title:
                                'Lack of Integration and Interoperability of Agricultural Technologies',
                            imagePath:
                                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTl1tj1Qj_XwhoENFmTcrniOOrV9lrDq3AG8p4BG8mDM-yhLJWU',
                            description:
                                ' The agricultural sector is flooded with various technologies, software platforms, and equipment that often lack integration and interoperability',
                          ),
                          MCard(
                            title:
                                'Insufficient Data Management and Analytics Capabilitie',
                            imagePath:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjXU7v8q8CWcYQjciHqGc1SVy6VIGOjXPuyQFXrVeAeVumQGEJ',
                            description:
                                ' Modern agriculture generates vast amounts of data from various sources like satellite imagery, weather forecasts, soil sensors, and farm machinery. ',
                          ),
                          MCard(
                            title:
                                'Cybersecurity Threats and Data Privacy Concerns',
                            imagePath:
                                'https://www.mesaonline.org/wp-content/uploads/2023/02/security-hack-piracy-lock-threat-091-1024x1024.jpg',
                            description:
                                'As agriculture becomes more digitized, farms increasingly rely on cloud-based services, smart devices, and digital platforms.',
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
                      "Labour and Social Issues",
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
                        //children: const [MCard(), MCard(), MCard(), MCard()],
                        children: const [
                          MCard(
                            title: 'Labor Shortages and High Labor Costs',
                            imagePath:
                                'https://www.shutterstock.com/image-photo/manual-labor-agriculturethe-concept-natural-260nw-2430203755.jpg',
                            description:
                                ' Many farmers face labor shortages due to urban migration, aging rural populations, and declining interest in agricultural work among younger generations.',
                          ),
                          MCard(
                            title:
                                ' Lack of Access to Social Security and Benefits for Farm Laborers',
                            imagePath:
                                'https://www.shutterstock.com/image-vector/lonely-people-set-sad-upset-600nw-2198678473.jpg',
                            description:
                                ' Agricultural laborers often work under informal contracts without social security, health insurance, or retirement benefits. ',
                          ),
                          MCard(
                            title: 'Gender Inequality and Discrimination',
                            imagePath:
                                'https://populationmatters.org/wp-content/uploads/2022/08/bigstock-closeup-of-a-young-caucasian-w-228079150.jpg',
                            description:
                                'Women play a significant role in agriculture, especially in tasks like sowing, weeding, and post-harvest processing. ',
                          ),
                          MCard(
                            title:
                                'Social Stigma and Lack of Dignity Associated with Farming',
                            imagePath:
                                'https://i.pinimg.com/200x/7f/57/cb/7f57cbb5c280b492bf34162ccea76dee.jpg',
                            description:
                                'Farming is often perceived as a low-status occupation, particularly among younger generations. ',
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
