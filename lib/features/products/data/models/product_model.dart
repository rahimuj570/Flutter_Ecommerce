class ProductModel {
  final String id;
  final String title;
  final String description;
  final List<String> photos;
  final List<String> colors;
  final List<String> sizes;
  final int? regularPrice;
  final int currentPrice;
  final int quantity;
  final bool inCart;
  final bool inWishlist;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.photos,
    required this.colors,
    required this.sizes,
    required this.regularPrice,
    required this.currentPrice,
    required this.quantity,
    required this.inCart,
    required this.inWishlist,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'photos': photos,
      'colors': colors,
      'sizes': sizes,
      'regular_price': regularPrice,
      'current_price': currentPrice,
      'quantity': quantity,
      'in_cart': inCart,
      'in_wishlist': inWishlist,
    };
  }
}
