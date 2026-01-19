class CartCardModel {
  final String id;
  final String productId;
  final String productTitle;
  final String? color;
  final String? size;
  int selectedQuantity;
  final String? photo;
  final int price;
  final int stockQuantity;

  CartCardModel({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.color,
    required this.size,
    required this.selectedQuantity,
    required this.photo,
    required this.price,
    required this.stockQuantity,
  });

  factory CartCardModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> product = json['product'];
    return CartCardModel(
      id: json['_id'],
      productId: product['_id'],
      productTitle: product['title'],
      color: json['color'],
      size: json['size'],
      selectedQuantity: json['quantity'],
      photo: product['photos'][0],
      price: product['current_price'],
      stockQuantity: product['quantity'],
    );
  }
  // {
  //  "_id": "6967a777f6079d6f14dd8e38",
  //               "product": {
  //                   "_id": "681255e2ea40bfc6edc673c9",
  //                   "title": "সফটওয়্যার ইঞ্জিনিয়ারিং আলাপ",
  //                   "brand": "6799d84bceaaf5d3413a0989",
  //                   "categories": [
  //                       "680d1b45408c2a3e015a83de"
  //                   ],
  //                   "slug": "softwarealap",
  //                   "meta_description": null,
  //                   "description": "সফটওয়্যার ইঞ্জিনিয়ারিং এ ক্যারিয়ার শুরু করা এখন তেমন একটা কঠিন না। কিন্তু ক্যারিয়ার শুরু করার পর সামনে বেশ কিছু চ্যালেঞ্জ আসে। কী শিখবো, কিভাবে শিখবো, কিভাবে ক্যারিয়ারে আরো ভালো করতে পারবো, কিভাবে সময়ের সাথে এই প্রতিযোগিতাপূর্ণ সেক্টরে টিকে থাকতে পারবো – এই বিষয়গুলো আমাদের অনেকেরই জিজ্ঞাসা। ল্যাঙ্গুয়েজ, ফ্রেমওয়ার্ক, টুল শেখার জন্য অনেক টিউটোরিয়াল, কোর্স আছে। কিন্তু সফটওয়্যার ইঞ্জিনিয়ারিং ক্যারিয়ারে সফলতার জন্য কেবল এগুলো শেখাই যথেষ্ট না। এর সাথে দরকার ইঞ্জিনিয়ারিং মাইন্ডসেট, সফট স্কিলস, লার্নিং টেকনিক, ক্যারিয়ারের ব্যাপারে সচেতনতা ইত্যাদি। দুঃখজনকভাবে এই দরকারী বিষয়গুলো নিয়ে তেমন একটা আলাপ হয় না বললেই চলে। অনেকে ক্যারিয়ারের বিভিন্ন পর্যায়ে বাস্তব অভিজ্ঞতা থেকে এবং ‘ঠেকে’ এই বিষয়গুলো আয়ত্ত করেন। অথচ ক্যারিয়ারের শুরুর দিকেই এই বিষয়গুলো জানা থাকলে আপনি ক্যারিয়ারে অন্যদের চেয়ে এগিয়ে থাকবেন অনেকদূর। ইংরেজিতে এসব টপিকে বেশ কিছু বই থাকলেও বাংলায় সম্ভবত এটাই প্রথম। কিভাবে নতুন নতুন টুল-টেকনোলজির চক্করে নিজেকে আপ-টু-ডেট রাখবেন, কিভাবে সফটওয়্যার ইঞ্জিনিয়ারিংয়ের নিত্যদিনের চ্যালেঞ্জগুলো মোকাবেলা করবেন, কোন কোন বিষয়গুলো আপনাকে ক্যারিয়ার বুস্টে সাহায্য করবে – এরকম ভিন্ন ভিন্ন টপিকের ২০ টি লেখার সংকলন এই বইটি।একজন ভালো সফটওয়্যার ইঞ্জিনিয়ার হতে, জব মার্কেটের প্রতিযোগিতায় টিকে থাকতে এবং সর্বোপরি আপনার ক্যারিয়ারে আরো এগিয়ে যেতে এই বইটি টনিকের মত কাজ করবে বলে আমাদের বিশ্বাস।",
  //                   "photos": [
  //                       "https://wafilife-media.wafilife.com/uploads/2023/05/Software-Engineering-Talk-Cover-01-250x370.jpg"
  //                   ],
  //                   "colors": [],
  //                   "sizes": [],
  //                   "tags": [],
  //                   "regular_price": null,
  //                   "current_price": 252,
  //                   "quantity": 1,
  //                   "createdAt": "2025-04-30T16:54:58.678Z",
  //                   "updatedAt": "2025-04-30T16:55:59.930Z",
  //                   "__v": 0
  //               },
  //               "user": "6953ddf4735c8919732f5e4d",
  //               "quantity": 1,
  //               "color": null,
  //               "size": null,
  //               "createdAt": "2026-01-14T14:25:59.046Z",
  //               "updatedAt": "2026-01-14T14:25:59.046Z",
  //               "__v": 0
  //           }
}
