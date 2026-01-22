class ReviewModel {
  final String reviewId;
  final String productId;
  final String avatarUrl;
  final String firstName;
  final String lastName;
  double rating;
  String comment;

  ReviewModel({
    required this.avatarUrl,
    required this.firstName,
    required this.lastName,
    required this.comment,
    required this.rating,
    required this.reviewId,
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {"product": productId, "comment": comment, "rating": rating};
  }

  factory ReviewModel.fromJson(Map<String, dynamic> body) {
    Map<String, dynamic> user = body['user'];
    return ReviewModel(
      reviewId: body['_id'],
      productId: body['product']['_id'],
      avatarUrl: user['_id'],
      firstName: user['first_name'],
      lastName: user['last_name'],
      comment: body['comment'],
      rating: body['rating'],
    );
  }

  // {
  //               "_id": "697134c7643de2464954eec2",
  //               "product": {
  //                   "_id": "6812588dea40bfc6edc673ed",
  //                   "title": "সহজ ভাষায় অ্যালগরিদম",
  //                   "slug": "sohojvasaialgorithom",
  //                   "photos": [
  //                       "https://ds.rokomari.store/rokomari110/ProductNew20190903/260X372/Sohoj_Bhashay_Algorithm-Ihsanul_Islam-ab6e3-227461.jpg"
  //                   ]
  //               },
  //               "user": {
  //                   "_id": "696b81291d252c0ba332ffe4",
  //                   "first_name": "anower",
  //                   "last_name": "siyam",
  //                   "avatar_url": null
  //               },
  //               "rating": 4,
  //               "comment": "nice book",
  //               "createdAt": "2026-01-21T20:19:19.604Z",
  //               "updatedAt": "2026-01-21T20:19:19.604Z",
  //               "__v": 0
  //           },
}
