class CartModel {
  final String image;
  final String title;
  final int price;
  final String details;
  int count;

  CartModel({
    required this.details,
    required this.count,
    required this.image,
    required this.title,
    required this.price,
  });
}
