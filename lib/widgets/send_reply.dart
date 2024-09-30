import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class SendReply extends StatefulWidget {
  final String postId;
  final VoidCallback onReplySent; // Callback function to refresh replies

  const SendReply({super.key, required this.postId, required this.onReplySent});

  @override
  State<SendReply> createState() => _SendReplyState();
}

class _SendReplyState extends State<SendReply> {
  final translator = GoogleTranslator();
  final _formKey = GlobalKey<FormState>();
  final _answerC = TextEditingController();

  Future<void> _sendReply() async {
    if (_formKey.currentState!.validate()) {
      String answerText = _answerC.text.trim();
      String userId = FirebaseAuth.instance.currentUser!
          .uid; // Replace with actual user ID retrieval logic

      DocumentReference replyRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('replies')
          .doc();

      Map<String, dynamic> replyData = {
        'userId': userId,
        'text': answerText,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await replyRef.set(replyData);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'replyIds': FieldValue.arrayUnion([replyRef.id]),
      });

      _answerC.clear();

      // Call the callback function to refresh replies in the parent widget
      widget.onReplySent();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          SizedBox(
            width: width * 0.82,
            child: TextFormField(
              controller: _answerC,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Your Answer',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide:
                      const BorderSide(color: Color(0xff1A5319), width: 2.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              cursorColor: const Color(0xff1A5319),
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an answer';
                }
                return null;
              },
            ),
          ),
          Positioned(
            left: width * 0.82,
            child: IconButton(
              onPressed: _sendReply,
              icon: Icon(
                Icons.send,
                size: width * 0.1,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
