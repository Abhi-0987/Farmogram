import 'package:farmogram/widgets/send_reply.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PostFullDisplayScreen extends StatefulWidget {
  final String postId;

  const PostFullDisplayScreen({super.key, required this.postId});

  @override
  _PostFullDisplayScreenState createState() => _PostFullDisplayScreenState();
}

class _PostFullDisplayScreenState extends State<PostFullDisplayScreen> {
  late Future<DocumentSnapshot> postFuture;
  late Future<QuerySnapshot> repliesFuture;

  @override
  void initState() {
    super.initState();
    postFuture =
        FirebaseFirestore.instance.collection('posts').doc(widget.postId).get();
    repliesFuture = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .collection('replies')
        .get();
  }

  void _refreshReplies() {
    setState(() {
      repliesFuture = FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('replies')
          .get();
    });
  }

  Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      return userDoc.data() as Map<String, dynamic>?;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Post not found'));
          }

          var postData = snapshot.data!.data() as Map<String, dynamic>;
          var imageUrl = postData['imageUrl'] as String?;
          var question = postData['question'] as String?;
          var description = postData['description'] as String?;
          var date = postData['postedAt'];
          var state = postData['state'] as String?;

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: const Color(0xff80AF81),
                    expandedHeight: height * 0.4,
                    pinned: true,
                    flexibleSpace: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        var top = constraints.biggest.height;
                        var opacity = ((top - kToolbarHeight) /
                                (height * 0.4 - kToolbarHeight))
                            .clamp(0.0, 1.0);

                        return FlexibleSpaceBar(
                          title: Opacity(
                            opacity: 1.0 - opacity,
                            child: Text(question ?? 'Post'),
                          ),
                          background: Hero(
                            tag: imageUrl ?? '',
                            child: Image.network(
                              imageUrl ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                          collapseMode: CollapseMode.pin,
                          expandedTitleScale: 1.5,
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      color: const Color(0xffD6EFD8),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: width * 0.02),
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: width * 0.065,
                              ),
                              SizedBox(width: width * 0.02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('username'),
                                  Text(DateFormat('yyyy-MM-dd')
                                      .format((date as Timestamp).toDate())),
                                ],
                              ),
                              SizedBox(width: width * 0.02),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                padding: const EdgeInsets.all(2.0),
                                child: Text(state!),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            question ?? '',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            description ?? '',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const Divider(height: 40),
                          Text(
                            'Replies',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: true,
                    child: Container(
                      color: const Color(0xffD6EFD8),
                      child: FutureBuilder<QuerySnapshot>(
                        future: repliesFuture,
                        builder: (context, replySnapshot) {
                          if (replySnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (!replySnapshot.hasData ||
                              replySnapshot.data == null) {
                            return const Center(
                                child: Text('No replies found'));
                          }

                          var replies = replySnapshot.data!.docs;

                          return ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            itemCount: replies.length,
                            itemBuilder: (context, index) {
                              var replyData =
                                  replies[index].data() as Map<String, dynamic>;
                              var userId = replyData['userId'] as String?;

                              return FutureBuilder<Map<String, dynamic>?>(
                                future: fetchUserData(userId!),
                                builder: (context, userSnapshot) {
                                  if (userSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  if (!userSnapshot.hasData ||
                                      userSnapshot.data == null) {
                                    return const Center(
                                        child: Text('User not found'));
                                  }

                                  var userData = userSnapshot.data!;
                                  var username = userData['name'] as String?;
                                  var location = userData['state'] as String?;

                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    elevation: 4,
                                    shadowColor: Colors.black26,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Colors.green[200],
                                                child: Text(
                                                  username![0].toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                username,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green[800],
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Text(location ?? 'India')
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            replyData['text'] ?? '',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                DateFormat('yyyy-MM-dd').format(
                                                    (replyData['timestamp']
                                                            as Timestamp)
                                                        .toDate()),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
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
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: width,
                  padding: const EdgeInsets.all(8.0),
                  color: const Color(0xff80AF81),
                  child: SendReply(
                    postId: widget.postId,
                    onReplySent: _refreshReplies,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
