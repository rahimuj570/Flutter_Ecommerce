class UriList {
  static const String _uri = 'https://ecom-rs8e.onrender.com/api';
  static const String signup = '$_uri/auth/signup';
  static const String login = '$_uri/auth/login';
  static const String verify = '$_uri/auth/verify-otp';
  static const String fetchSlides = '$_uri/slides';
  static String fetchCategories({
    required int postCount,
    required int pageNumber,
  }) => '$_uri/categories?count=$postCount&page=$pageNumber';
}
