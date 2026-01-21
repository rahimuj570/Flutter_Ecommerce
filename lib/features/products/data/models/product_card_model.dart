class ProductCardModel {
  final String id;
  final String title;
  final List<dynamic> photos;
  final int currentPrice;
  bool? inWishlist = false;
  final String? wishId;

  final int? indexFromParent;

  ProductCardModel({
    required this.id,
    required this.title,
    required this.photos,
    required this.currentPrice,
    required this.inWishlist,
    this.wishId,

    this.indexFromParent,
  });

  factory ProductCardModel.fromJson({
    required Map<String, dynamic> json,
    String? wishIdParam,
  }) {
    return ProductCardModel(
      id: json['_id'],
      title: json['title'],
      photos: json['photos'],
      currentPrice: json['current_price'],
      inWishlist: json['in_wishlist'],
      wishId: wishIdParam,
    );
  }
}
