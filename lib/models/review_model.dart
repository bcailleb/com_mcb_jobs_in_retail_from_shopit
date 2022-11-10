
class ReviewModel {
  final String senderName;
  final int userRating;
  final String description;
  ReviewModel({
    required this.senderName,
    required this.userRating,
    required this.description,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      senderName: json['senderName'],
      userRating: json['userRating'] as int,
      description: json['description'],
    );
  }

  Map<String, dynamic> getJson() {
    return {
      'senderName': senderName,
      'userRating': userRating,
      'description': description,
    };

  }
  static String collectionName = 'reviews';
}

