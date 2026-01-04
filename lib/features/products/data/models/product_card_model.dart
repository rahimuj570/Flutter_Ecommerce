class ProductCardModel {
  final String id;
  final String title;
  final List<dynamic> photos;
  final int currentPrice;
  final bool? inWishlist;

  ProductCardModel({
    required this.id,
    required this.title,
    required this.photos,
    required this.currentPrice,
    required this.inWishlist,
  });

  factory ProductCardModel.fromJson(Map<String, dynamic> json) {
    return ProductCardModel(
      id: json['_id'],
      title: json['title'],
      photos: json['photos'],
      currentPrice: json['current_price'],
      inWishlist: json['in_wishlist'],
    );
  }
}
