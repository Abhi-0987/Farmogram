// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmogram/models/post_model.dart';
import 'package:farmogram/screens/ask_screen.dart';
import 'package:farmogram/screens/main_screen.dart';
import 'package:farmogram/widgets/posts_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final translator = GoogleTranslator();
  int _questions = 0;
  int _contributions = 0;
  final Map<String, String> translations = {
    'appname': 'Farmogram',
    'questions': 'Your Questions',
    'online': 'Members online 😄',
    'contribute': 'Your Contributions',
    'tab2': 'Trending',
    'tab3': 'Marketplace'
  };
  final Map<String, String> textsToTranslate = {
    'appname': 'Farmogram',
    'questions': 'Your Questions',
    'online': 'Members online 😄',
    'contribute': 'Your Contributions',
    'tab2': 'Trending',
    'tab3': 'Marketplace'
  };

  @override
  void initState() {
    super.initState();
    _translateTexts();
  }

  Future<void> _translateTexts() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    List<dynamic> questions = userDoc.data()?['postIds'] ?? [];
    List<dynamic> contributions = userDoc.data()?['replyIds'] ?? [];
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
        // Handle error (showing a snackbar as an example)
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error during translation: $e')),
          );
        }
      }
    }
    if (mounted) {
      setState(() {
        _questions = questions.length;
        _contributions = contributions.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xffD6EFD8),
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
          PopupMenuButton<String>(
              onSelected: (String value) {
                // Handle the selected option
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You selected: $value'),
                  ),
                );
              },
              itemBuilder: (BuildContext context) {
                return {'Option 1', 'Option 2', 'Option 3'}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              icon: const Icon(Icons.more_horiz_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff80AF81), // Main container color
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // First Container
                          Container(
                            width: width * 0.3,
                            decoration: BoxDecoration(
                              color: const Color(0xffD6EFD8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width * 0.28,
                                  child: Text(
                                    translations['questions']!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: width * 0.04,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  _questions.toString(),
                                  style: TextStyle(
                                    fontSize: width * 0.07,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Second Container
                          Container(
                            width: width * 0.3,
                            decoration: BoxDecoration(
                              color: const Color(0xff508D4E),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width * 0.28,
                                  child: Text(
                                    translations['online']!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: width * 0.04,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  '4',
                                  style: TextStyle(
                                    fontSize: width * 0.07,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Third Container
                          Container(
                            width: width * 0.3,
                            decoration: BoxDecoration(
                              color: const Color(0xff1A5319),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width * 0.28,
                                  child: Text(
                                    translations['contribute']!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: width * 0.04,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  _contributions.toString(),
                                  style: TextStyle(
                                    fontSize: width * 0.07,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        width: width * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: Colors.grey[300]),
                            prefixIcon: const Icon(Icons.search,
                                color: Color.fromARGB(255, 125, 151, 162)),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: height * 0.62,
                    width: width * 0.96,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final posts = snapshot.data!.docs.map((doc) {
                          return PostModel.fromJson(
                              doc.data() as Map<String, dynamic>);
                        }).toList();

                        return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                PostsWidget(
                                  post: posts[index],
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: width * 0.64,
              top: height * 0.72,
              child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AskScreen())),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 63, 210, 0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [Icon(Icons.edit), Text('Ask Community')],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Posts extends StatefulWidget {
  const Posts(
      {super.key,
      required this.values,
      required this.height,
      required this.width});
  final Future<List<Map<String, dynamic>>> values;
  final double height;
  final double width;

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: widget.values,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No documents found'));
          } else {
            // List<Map<String, dynamic>> documents = snapshot.data!;
            return ListView(
                // children: documents
                //     .map((data) => Column(
                //           children: [
                //             RideDetailsTile(
                //               values: ScheduleModel.fromJson(data),
                //               flag: false,
                //               screen: 'view',
                //             ),
                //             SizedBox(
                //               height: widget.height * 0.02,
                //             )
                //           ],
                //         ))
                //     .toList(),
                );
          }
        },
      ),
    );
  }
}
