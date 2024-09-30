import 'package:farmogram/screens/upload_reel.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _pageController = PageController();
  List<Map<String, dynamic>> _videos = [];
  int currentIndex = 0;
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  Future<void> _fetchVideos() async {
    try {
      // Fetch video data from Firestore
      QuerySnapshot videoSnapshot =
          await FirebaseFirestore.instance.collection('videos').get();
      List<Map<String, dynamic>> videoList = [];

      for (var doc in videoSnapshot.docs) {
        videoList.add(doc.data() as Map<String, dynamic>);
      }

      setState(() {
        _videos = videoList;
        if (_videos.isNotEmpty) {
          _initializeVideoPlayer(currentIndex);
        }
      });
    } catch (e) {
      print('Failed to fetch videos: $e');
    }
  }

  void _initializeVideoPlayer(int index) {
    _videoPlayerController?.dispose();
    if (_videos.isNotEmpty) {
      String videoUrl = _videos[index]['videoUrl'];
      _videoPlayerController = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController?.setLooping(true);
          _videoPlayerController?.play();
        });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _videos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
                _initializeVideoPlayer(index);
              },
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(_videos[index]['userId'])
                      .get(),
                  builder: (context, userSnapshot) {
                    if (!userSnapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    var userData =
                        userSnapshot.data!.data() as Map<String, dynamic>;
                    return Stack(
                      children: [
                        _videoPlayerController != null &&
                                _videoPlayerController!.value.isInitialized
                            ? Center(
                                child: AspectRatio(
                                  aspectRatio:
                                      _videoPlayerController!.value.aspectRatio,
                                  child: VideoPlayer(_videoPlayerController!),
                                ),
                              )
                            : const Center(child: CircularProgressIndicator()),
                        _buildOverlay(index, userData),
                      ],
                    );
                  },
                );
              },
            ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: const UploadVideoScreen(),
            ),
          );
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.upload),
            SizedBox(width: 8),
            Text('Upload Video'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  Widget _buildOverlay(int index, Map<String, dynamic> userData) {
    var width = MediaQuery.of(context).size.width;
    return Positioned.fill(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green[200],
                      child: Text(
                        userData['name'][0] ?? 'unknown'[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      '@${userData['name'] ?? 'unknown'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: width * 0.8,
                  child: Text(
                    _videos[index]['description'] ?? 'No description...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.white),
                  onPressed: () {
                    // Handle like action
                  },
                ),
                const SizedBox(height: 10),
                IconButton(
                  icon: const Icon(Icons.comment, color: Colors.white),
                  onPressed: () {
                    // Handle comment action
                  },
                ),
                const SizedBox(height: 10),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: () {
                    // Handle share action
                  },
                ),
                const SizedBox(height: 10),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () {
                    // Handle more options
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
