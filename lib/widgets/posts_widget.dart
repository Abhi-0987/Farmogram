import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmogram/models/post_model.dart';
import 'package:farmogram/screens/main_screen.dart';
import 'package:farmogram/screens/post_desc_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';

class PostsWidget extends StatefulWidget {
  const PostsWidget({required this.post, super.key});
  final PostModel post;

  @override
  State<PostsWidget> createState() => _PostsWidgetState();
}

class _PostsWidgetState extends State<PostsWidget> {
  final translator = GoogleTranslator();
  final Map<String, String> translations = {
    'question': '',
    'description': '',
    'username': ' ',
    'state': ' ',
    'answers': ' '
  };

  @override
  void initState() {
    super.initState();
    _translateTexts();
  }

  Future<void> _translateTexts() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.post.userId!)
        .get();
    final String username = userDoc.data()?['name'];
    final Map<String, String> textsToTranslate = {
      'question': widget.post.question!,
      'description': widget.post.description!,
      'username': username,
      'state': widget.post.state!,
      'answers': 'answers'
    };
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PostFullDisplayScreen(postId: widget.post.postId!)));
      },
      child: Container(
        width: width * 0.96,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(2, 3))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: height * 0.26,
              child: Image.network(
                widget.post.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.02,
                ),
                CircleAvatar(
                  backgroundColor: Colors.green[200],
                  child: Text(
                    translations['username']![0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Column(
                  children: [
                    Text(translations['username']!),
                    Text(DateFormat('yyyy-MM-dd').format(widget.post.postedAt!))
                  ],
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(translations['state']!),
                    ))
              ],
            ),
            SizedBox(
              width: width * 0.9,
              child: Text(
                translations['question']!,
                style: TextStyle(fontSize: width * 0.044),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(
              width: width * 0.9,
              child: Text(translations['description']!),
            ),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.thumb_down)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                const Text('5'),
                SizedBox(
                  width: width * 0.01,
                ),
                Text(translations['answers']!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
