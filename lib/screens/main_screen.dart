import 'package:farmogram/screens/community_screen.dart';
import 'package:farmogram/screens/home_screen.dart';
import 'package:farmogram/screens/professional.dart';
import 'package:farmogram/screens/profile_screen.dart';
import 'package:farmogram/screens/reels_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static String uid = "";
  static String login = "";
  static String myLang = "en";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomeScreen(),
    const CommunityScreen(),
    const ProfessionalAdviceScreen(),
    const ProfileScreen()
  ];

  Future<void> _saveLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    MainScreen.myLang = prefs.getString('preferred_language') ?? 'en';
  }

  @override
  void initState() {
    super.initState();
    // _saveLanguagePreference();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: _children[_currentIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              child: const ReelsScreen(),
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Transform.scale(
            scale: 1.7,
            child: Lottie.asset(
              'assets/reels.json',
              fit: BoxFit.fitWidth,
              repeat: true, // Ensures the animation loops continuously
              animate: true, // Ensures the animation plays
              reverse:
                  true, // Keeps the animation playing in a forward direction
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xff1A5319),
          clipBehavior: Clip.antiAlias,
          height: height * 0.065,
          elevation: 0,
          padding: const EdgeInsets.all(4),
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Iconify(
                  MaterialSymbols.home,
                  color: _currentIndex == 0
                      ? Colors.white
                      : Colors.black, // highlight if selected
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              IconButton(
                icon: Iconify(
                  MaterialSymbols.groups_outline,
                  color: _currentIndex == 1
                      ? Colors.white
                      : Colors.black, // highlight if selected
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              SizedBox(
                width: width * 0.06,
              ),
              IconButton(
                icon: Iconify(
                  Healthicons.agriculture_worker_alt,
                  color: _currentIndex == 2
                      ? Colors.white
                      : Colors.black, // highlight if selected
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              IconButton(
                icon: Iconify(
                  MaterialSymbols.person,
                  color: _currentIndex == 3
                      ? Colors.white
                      : Colors.black, // highlight if selected
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),
            ],
          ),
        ));
  }
}
