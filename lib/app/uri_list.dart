class UriList {
  static const String _baseUri = 'https://ecom-rs8e.onrender.com/api';
  static const String signup = '$_baseUri/auth/signup';
  static const String login = '$_baseUri/auth/login';
  static const String verify = '$_baseUri/auth/verify-otp';
  static const String fetchSlides = '$_baseUri/slides';
  static String fetchCategories({
    required int postCount,
    required int pageNumber,
  }) => '$_baseUri/categories?count=$postCount&page=$pageNumber';
  static String fetchProductCards(int count, int pageNo, String categoryId) =>
      '$_baseUri/products?count=$count&page=$pageNo&category=$categoryId';

  static String fetchProductById(String productId) =>
      '$_baseUri/products/id/$productId';
}
