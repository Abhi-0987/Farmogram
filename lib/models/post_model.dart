import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? description;
  String? imageUrl;
  String? postId;
  DateTime? postedAt;
  String? question;
  String? state;
  String? userId;

  PostModel({
    this.description,
    this.imageUrl,
    this.postId,
    this.postedAt,
    this.question,
    this.state,
    this.userId,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    imageUrl = json['imageUrl'];
    postId = json['postId'];

    // Convert Firestore Timestamp to DateTime
    postedAt = (json['postedAt'] as Timestamp).toDate();

    question = json['question'];
    state = json['state'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['postId'] = postId;

    // Convert DateTime to Firestore Timestamp
    data['postedAt'] = Timestamp.fromDate(postedAt!);
    data['question'] = question;
    data['state'] = state;
    data['userId'] = userId;
    return data;
  }
}
