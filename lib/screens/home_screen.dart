// ignore_for_file: use_build_context_synchronously
import 'package:farmogram/screens/EcoFertilizers.dart';
import 'package:farmogram/screens/disease_find.dart';
import 'package:farmogram/screens/insect_find.dart';
import 'package:farmogram/screens/login_screen.dart';
import 'package:farmogram/screens/main_screen.dart';
import 'package:farmogram/screens/post_harvesting.dart';
import 'package:farmogram/screens/pre_harvest.dart';
import 'package:farmogram/screens/road_maps.dart';
import 'package:farmogram/widgets/w_banner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/entypo.dart';
import 'package:iconify_flutter/icons/fontisto.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/pajamas.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:iconify_flutter/icons/iconoir.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final translator = GoogleTranslator();
  final Map<String, String> translations = {
    'appname': 'Farmogram',
    'welcomeMessage': 'Welcome to Farmogram!',
    'footerText': 'Thank you for using our app.',
    'insect': 'Insect Detection',
    'disease': 'Go to Disease Detection',
    'crop': 'Find your CROP',
    'tab1': 'Crops',
    'tab2': 'Farm-Tech',
    'tab3': 'Marketplace'
  };
  final Map<String, String> textsToTranslate = {
    'appname': 'Farmogram',
    'welcomeMessage': 'Welcome to Farmogram!',
    'footerText': 'Thank you for using our app.',
    'insect': 'Insect Detection',
    'disease': 'Go to Disease Detection',
    'crop': 'Find your CROP',
    'tab1': 'Crops',
    'tab2': 'Farm-Tech',
    'tab3': 'Marketplace'
  };

  @override
  void initState() {
    super.initState();
    _translateTexts();
  }

  Future<void> _launchInBrowser() async {
    Uri url = Uri.parse(
        'https://www.chatbase.co/chatbot-iframe/YSwkz7aJt700yX4W34Vu5');
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _translateTexts() async {
    for (var entry in textsToTranslate.entries) {
      try {
        final translation =
            await translator.translate(entry.value, to: MainScreen.myLang);
        if (mounted) {
          setState(() {
            translations[entry.key] = translation.text;
          });
        }
      } catch (e) {
        // Handle error (showing a snackbar as an example)
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error during translation: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      translations['tab1']!,
      translations['tab2']!,
      translations['tab3']!
    ];
    final List<MenuItem> menuItems = [
      MenuItem(text: 'Option 1', icon: Icons.home),
      MenuItem(text: 'Option 2', icon: Icons.settings),
      MenuItem(text: 'Logout', icon: Icons.logout),
    ];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TabController tabc = TabController(length: tabs.length, vsync: this);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        bottomOpacity: 0,
        shadowColor: const Color(0xff80AF81),
        surfaceTintColor: const Color(0xff80AF81),
        backgroundColor: const Color(0xff80AF81),
        title: Text(
          translations['appname']!,
          style: TextStyle(fontSize: width * 0.07),
        ),
        toolbarHeight: height * 0.08,
        actions: [
          Icon(
            Icons.notifications,
            size: width * 0.07,
          ),
          PopupMenuButton<MenuItem>(
            onSelected: (MenuItem item) async {
              if (item.text != 'Logout') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You selected: ${item.text}'),
                  ),
                );
              } else {
                MainScreen.login == 'google'
                    ? await GoogleSignIn().signOut()
                    : await FirebaseAuth.instance.signOut();

                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                await prefs.setString('uid', '');

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }
            },
            itemBuilder: (BuildContext context) {
              return menuItems.map((MenuItem item) {
                return PopupMenuItem<MenuItem>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(item.icon, color: Colors.black),
                      const SizedBox(width: 10),
                      Text(item.text),
                    ],
                  ),
                );
              }).toList();
            },
            icon: const Icon(Icons.more_horiz_outlined),
          )
        ],
      ),
      body: Stack(children: [
        NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrollable) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: const Color(0xffD6EFD8),
                expandedHeight: height * 0.615,
                flexibleSpace: Container(
                  color: const Color(0xff80AF81),
                  child: ListView(
                    padding: EdgeInsets.only(bottom: height * 0.015),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      ListView(
                          padding: EdgeInsets.only(bottom: height * 0.015),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: const [
                            WBanner(),
                          ]),
                      Padding(
                        padding: EdgeInsets.all(width * 0.025),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: const DiseaseDetectionScreen(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // Light green background
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(
                                    0xff1A5319), // Dark green border
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: height * 0.12,
                                      child: Transform.scale(
                                          scale: 1,
                                          child: Lottie.asset(
                                              'assets/disease.json')),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      translations['disease']!,
                                      style: TextStyle(
                                        color: const Color(
                                            0xff1A5319), // Dark green text
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.05,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.leftToRight,
                                  child: const InsectFind(),
                                ),
                              );
                            },
                            child: Container(
                              width: width * 0.45,
                              decoration: BoxDecoration(
                                color: Colors.white, // Light green background
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(
                                      0xff1A5319), // Dark green border
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: width * 0.2,
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          height: height * 0.1,
                                          child: Transform.scale(
                                              scale: 1,
                                              child: Lottie.asset(
                                                  'assets/insect.json')),
                                        ),
                                        SizedBox(
                                          height: height * 0.1,
                                          child: Transform.scale(
                                              scale: 2,
                                              child: Lottie.asset(
                                                  'assets/scanner.json')),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.2,
                                    child: Text(
                                      translations['insect']!,
                                      style: TextStyle(
                                        color: const Color(
                                            0xff1A5319), // Dark green text
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.04,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: width * 0.45,
                              decoration: BoxDecoration(
                                color: Colors.white, // Light green background
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(
                                      0xff1A5319), // Dark green border
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: height * 0.1,
                                    child: Transform.scale(
                                        scale: 1,
                                        child:
                                            Lottie.asset('assets/plant.json')),
                                  ),
                                  SizedBox(
                                    width: width * 0.2,
                                    child: Column(
                                      children: [
                                        Text(
                                          translations['crop']!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(
                                                0xff1A5319), // Dark green text
                                            fontWeight: FontWeight.bold,
                                            fontSize: width * 0.04,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                  child: Container(
                    height: AppBar().preferredSize.height,
                    color: Colors.white,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xff80AF81),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          )),
                      child: TabBar(
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        indicatorColor: const Color.fromARGB(255, 20, 60, 19),
                        labelColor: const Color.fromARGB(255, 20, 62, 19),
                        tabAlignment: TabAlignment.startOffset,
                        controller: tabc,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelStyle: TextStyle(
                            fontFamily: "josefin",
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.bold),
                        tabs: tabs.map((tab) => Tab(text: tab)).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: tabc,
            children: const [
              CropsScreen(),
              CultivationTipsPage(),
              DataSubmissionScreen(),
            ],
          ),
        ),
        Positioned(
          top: height * 0.71,
          left: width * 0.8,
          child: GestureDetector(
            onTap: () async {
              _launchInBrowser();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xff1A5319),
                  border: Border.all(color: Colors.green),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(100))),
              height: height * 0.09,
              width: width * 0.17,
              child: Transform.scale(
                  scale: 0.8, child: Lottie.asset('assets/ai.json')),
            ),
          ),
        ),
      ]),
    );
  }
}

class CropsScreen extends StatefulWidget {
  const CropsScreen({super.key});

  @override
  State<CropsScreen> createState() => _CropsScreenState();
}

class _CropsScreenState extends State<CropsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.35,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Quick Access",
                        style: TextStyle(
                          fontSize: width * 0.056,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        QACards(
                          text: "Pre-Harvest Issues",
                          route: const PreHarvest(),
                          icon: Iconify(
                            GameIcons.plant_roots,
                            size: width * 0.09,
                          ),
                        ),
                        QACards(
                          text: "Post-Harvest Issues",
                          route: const PostHarvesting(),
                          icon: Iconify(
                            GameIcons.plant_watering,
                            size: width * 0.09,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        QACards(
                          text: "Eco-Friendly fertilizers",
                          route: EcoFertilizersScreen(),
                          icon: Iconify(
                            GameIcons.fertilizer_bag,
                            size: width * 0.09,
                          ),
                        ),
                        QACards(
                          text: "Soil Data",
                          route: const PreHarvest(),
                          icon: Iconify(
                            Carbon.soil_temperature,
                            size: width * 0.09,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const MBanner(
                title: "Roadmaps to crop",
                description:
                    "Learn about the best practices for growing crops"),
            SizedBox(
              height: height * 0.02,
            ),
            const MBanner(
                title: "Roadmaps to crop",
                description:
                    "Learn about the best practices for growing crops"),
          ],
        ),
      ),
    );
  }
}

class QACards extends StatefulWidget {
  const QACards(
      {super.key, required this.text, required this.route, required this.icon});
  final String text;
  final dynamic route;
  final Iconify icon;

  @override
  State<QACards> createState() => _QACardsState();
}

class _QACardsState extends State<QACards> {
  final translator = GoogleTranslator();
  String tText = "";

  @override
  void initState() {
    super.initState();
    _translateText();
  }

  Future<void> _translateText() async {
    try {
      final translation = await translator.translate(widget.text,
          from: 'en', to: MainScreen.myLang);
      if (mounted) {
        setState(() {
          tText = translation.text;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error during translation: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => widget.route)),
      child: Container(
        height: height * 0.12,
        width: width * 0.46,
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
          child: Row(
            children: [
              widget.icon,
              SizedBox(
                width: width * 0.01,
              ),
              SizedBox(
                width: width * 0.27,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    tText == "" ? widget.text : tText,
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MBanner extends StatefulWidget {
  const MBanner({super.key, required this.title, required this.description});
  final String title;
  final String description;

  @override
  State<MBanner> createState() => _MBannerState();
}

class _MBannerState extends State<MBanner> {
  final translator = GoogleTranslator();
  final Map<String, String> translations = {
    'title': "Roadmaps to crop",
    'description': "Learn about the best practices for growing crops",
    'buttonT': 'Start now',
  };

  @override
  void initState() {
    super.initState();
    _translateTexts();
  }

  Future<void> _translateTexts() async {
    final textsToTranslate = {
      'title': widget.title,
      'description': widget.description,
      'buttonT': 'Start now',
    };

    for (var entry in textsToTranslate.entries) {
      try {
        final translation = await translator.translate(entry.value,
            from: 'en', to: MainScreen.myLang);
        if (mounted) {
          setState(() {
            translations[entry.key] = translation.text;
          });
        }
      } catch (e) {
        if (mounted) {
          // Handle error (showing a snackbar as an example)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error during translation: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.97,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 0.55,
                    child: Text(
                      translations['title']!,
                      style: TextStyle(
                          fontSize: width * 0.045, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.55,
                    child: Text(
                      translations['description']!,
                      style: TextStyle(fontSize: width * 0.037),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RoadMaps())),
                    style: ElevatedButton.styleFrom(
                        elevation: 0.5,
                        backgroundColor:
                            const Color.fromARGB(224, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width * 0.03))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          translations['buttonT']!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            Container(
              height: height * 0.13,
              width: width * 0.3,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  MenuItem({required this.text, required this.icon});
}

class CultivationTipsPage extends StatefulWidget {
  const CultivationTipsPage({super.key});

  @override
  _CultivationTipsPageState createState() => _CultivationTipsPageState();
}

class _CultivationTipsPageState extends State<CultivationTipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildTaskView());
  }

  Widget _buildTaskView() {
    return ListView(
      children: [
        ListTile(
          leading: const Iconify(Pajamas.api),
          title: const Text('Precision Agriculture'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(
          color: Color.fromARGB(255, 216, 212, 212),
          indent: 20.0,
          endIndent: 20.0,
        ),
        ListTile(
          // widget

          leading: const Iconify(Healthicons.animal_spider),
          title: const Text(' Integrated Pest Management (IPM)'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(
          color: Color.fromARGB(255, 216, 212, 212),
          indent: 20.0,
          endIndent: 20.0,
        ),
        ListTile(
          leading: const Iconify(Pepicons.smartphone),
          title: const Text(' Smart Irrigation Systems'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(
          color: Color.fromARGB(255, 216, 212, 212),
          indent: 20.0,
          endIndent: 20.0,
        ),
        ListTile(
          leading: const Iconify(Iconoir.soil_alt),
          title: const Text(' Conservation Agriculture'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(
          color: Color.fromARGB(255, 216, 212, 212),
          indent: 20.0,
          endIndent: 20.0,
        ),
        ListTile(
          leading: const Iconify(MaterialSymbols.align_vertical_bottom),
          title: const Text('Hydroponics and Vertical Farming'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(
          color: Color.fromARGB(255, 216, 212, 212),
          indent: 20.0,
          endIndent: 20.0,
        ),
        ListTile(
          leading: const Iconify(Fontisto.injection_syringe),
          title: const Text(' Biotechnology and Genetically Modified Crops'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(
          color: Color.fromARGB(255, 216, 212, 212),
          indent: 20.0,
          endIndent: 20.0,
        ),
        ListTile(
          leading: const Iconify(MaterialSymbols.sunny_snowing), // widget,
          title: const Text('Sustainable Agriculture Practices'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(
          color: Color.fromARGB(255, 216, 212, 212),
          indent: 20.0,
          endIndent: 20.0,
        ),
        ListTile(
          leading: const Iconify(Entypo.tools),
          title: const Text('Data-Driven Agriculture'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(
          color: Color.fromARGB(255, 216, 212, 212),
          indent: 20.0,
          endIndent: 20.0,
        ),
        ListTile(
          leading: const Iconify(Carbon.crop_health), // widget,
          title: const Text('Sustainable Livestock Management'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(
          color: Color.fromARGB(255, 216, 212, 212),
          indent: 20.0,
          endIndent: 20.0,
        ),
        ListTile(
          leading: const Iconify(Carbon.energy_renewable), // widget,
          title: const Text(' Renewable Energy in Agriculture'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(
          color: Color.fromARGB(255, 216, 212, 212),
          indent: 20.0,
          endIndent: 20.0,
        ),
      ],
    );
  }
}

class DataSubmissionScreen extends StatefulWidget {
  const DataSubmissionScreen({super.key});

  @override
  _DataSubmissionScreenState createState() => _DataSubmissionScreenState();
}

class _DataSubmissionScreenState extends State<DataSubmissionScreen> {
  final List<String> states = [
    'Telangana',
    'Andhra Pradesh',
    'Karnataka'
  ]; // Add more states
  bool _isLoading = false;
  final List<String> districts = [
    'Medak',
    'Hyderabad',
    'Warangal'
  ]; // Add more districts
  final List<String> commodities = [
    'Rice',
    'Wheat',
    'Maize'
  ]; // Add more commodities

  String? selectedState;
  String? selectedDistrict;
  String? selectedCommodity;
  String responseData = '';

  String apiUrl =
      'https://api.data.gov.in/resource/35985678-0d79-46b4-9ed6-6f13308a1d24?api-key=579b464db66ec23bdd0000018eefb1a46bae427660145c54077db573&format=json';

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    if (selectedState == null ||
        selectedDistrict == null ||
        selectedCommodity == null) {
      // Show an error if any field is not selecteZZZZZZSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS`  d
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please select all fields before submitting.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final url = Uri.parse(
        '$apiUrl&filters%5BState.keyword%5D=$selectedState&filters%5BDistrict.keyword%5D=$selectedDistrict&filters%5BCommodity.keyword%5D=$selectedCommodity');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = response.body; // Get the raw JSON response
        print(data);

        // Since the API returns JSON, we should parse it as JSON
        // final jsonData = jsonDecode(data);

        // For this example, let's assume we want to display the raw response
        responseData = data;

        // Show the dialog with the parsed data
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Response'),
            content: Text('Data fetched successfully:\n$responseData'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        setState(() {
          _isLoading = false;
        });
      } else {
        // Handle non-200 responses
        setState(() {
          _isLoading = false;
        });
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Submission'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: selectedState,
                hint: const Text('Select State'),
                items: states.map((state) {
                  return DropdownMenuItem(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedState = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedDistrict,
                hint: const Text('Select District'),
                items: districts.map((district) {
                  return DropdownMenuItem(
                    value: district,
                    child: Text(district),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDistrict = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCommodity,
                hint: const Text('Select Commodity'),
                items: commodities.map((commodity) {
                  return DropdownMenuItem(
                    value: commodity,
                    child: Text(commodity),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCommodity = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: fetchData,
                      child: const Text('Submit'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
