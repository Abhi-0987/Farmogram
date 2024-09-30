// ignore_for_file: use_build_context_synchronously
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmogram/screens/language_selection.dart';
import 'package:farmogram/screens/login_screen.dart';
import 'package:farmogram/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:colorful_iconify_flutter/icons/logos.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final bool _forgotPass = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start position: just below the screen
      end: Offset.zero, // End position: where the widget should be
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _registerWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      MainScreen.uid = userCredential.user!.uid;
      MainScreen.login = 'email';

      final userDoc =
          _firestore.collection('users').doc(userCredential.user!.uid);
      await userDoc.set({
        'name': _username.text,
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('uid', userCredential.user!.uid);

      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const LanguageSelectionScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The password provided is too weak')),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('The account already exists fot this mail')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth!.idToken,
        accessToken: googleAuth.accessToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;

      MainScreen.uid = user!.uid;
      MainScreen.login = 'google';

      // Add user details to database with user ID
      final userDoc = _firestore.collection('users').doc(user.uid);
      await userDoc.set({
        'name': user.displayName,
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('uid', user.uid);
      // Move to next screen

      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const LanguageSelectionScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/authenticate.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: height * 0.1),
                SizedBox(
                  height: height * 0.023,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Welcome to',
                          style: TextStyle(
                              color: Colors.white, fontSize: width * 0.05)),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('FARMOGRAM',
                          style: TextStyle(
                              color: Colors.white, fontSize: width * 0.14)),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Join the growing community of farmers',
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.05)),
                  ],
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: _offsetAnimation,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: width * 0.04, right: width * 0.04),
                      height: height * 0.65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.transparent,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: height * 0.04,
                            ),
                            TextField(
                              controller: _username,
                              decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(255, 11, 117, 41)
                                        .withOpacity(0.6),
                                filled: true,
                                contentPadding: EdgeInsets.all(height * 0.023),
                                labelText: 'Username',
                                hintText: 'Enter your Username',
                                hintStyle: const TextStyle(color: Colors.white),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, right: width * 0.02),
                                  child: Icon(
                                    Icons.person_2_outlined,
                                    color: Colors.white,
                                    size: width * 0.08,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                focusColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(255, 11, 117, 41)
                                        .withOpacity(0.6),
                                filled: true,
                                contentPadding: EdgeInsets.all(height * 0.023),
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                hintStyle: const TextStyle(color: Colors.white),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, right: width * 0.02),
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: Colors.white,
                                    size: width * 0.08,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                focusColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            if (!_forgotPass)
                              Column(
                                children: [
                                  TextField(
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.all(height * 0.023),
                                      labelText: 'Password',
                                      hintStyle:
                                          const TextStyle(color: Colors.white),
                                      hintText: 'Enter your password',
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.05,
                                            right: width * 0.02),
                                        child: Icon(
                                          Icons.lock_outline,
                                          color: Colors.white,
                                          size: width * 0.08,
                                        ),
                                      ),
                                      fillColor:
                                          const Color.fromARGB(255, 11, 117, 41)
                                              .withOpacity(0.6),
                                      filled: true,
                                      labelStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      focusColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    obscureText: true,
                                  ),
                                  SizedBox(
                                    height: height * 0.0001,
                                  ),
                                  ClipRRect(
                                    clipBehavior: Clip.none,
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          {_registerWithEmailAndPassword()},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 1, 73, 23),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.25,
                                            vertical: height * 0.013),
                                      ),
                                      child: const Text(
                                        'Signup',
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
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 1,
                                  width: width * 0.3,
                                  color: Colors.white,
                                ),
                                Text(
                                  'OR',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.05),
                                ),
                                Container(
                                  height: 1,
                                  width: width * 0.3,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () => {_signInWithGoogle()},
                                  child: Container(
                                    height: height * 0.07,
                                    width: width * 0.35,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black.withOpacity(0.3)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Iconify(
                                            Logos.google_icon,
                                            size: width * 0.08,
                                          ),
                                          Text(
                                            'Google',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width * 0.05),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: height * 0.07,
                                    width: width * 0.35,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black.withOpacity(0.3)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Iconify(
                                            Logos.facebook,
                                            size: width * 0.08,
                                          ),
                                          Text(
                                            'Facebook',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width * 0.05),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.04),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.leftToRight,
                                        duration:
                                            const Duration(milliseconds: 800),
                                        curve: Curves.easeInOutQuint,
                                        child: const LoginScreen(),
                                      ),
                                    )
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                      color: Colors.white,
                                      fontSize: width * 0.05,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
