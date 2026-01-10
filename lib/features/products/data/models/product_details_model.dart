class ProductDetailsModel {
  final String id;
  final String title;
  final String description;
  final List<String> photos;
  final List<String> colors;
  final List<String> sizes;
  final int currentPrice;
  final int quantity;

  ProductDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.photos,
    required this.colors,
    required this.sizes,
    required this.currentPrice,
    required this.quantity,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      photos: json['photos'],
      colors: json['colors'],
      sizes: json['sizes'],
      currentPrice: json['currentPrice'],
      quantity: json['quantity'],
    );
  }
}
