class IceCream {
  final String image;
  final String title;
  final int price;
  final String details;
  final String category;

  IceCream({
    required this.category,
    required this.details,
    required this.image,
    required this.title,
    required this.price,
  });

  factory IceCream.fromJson(Map<String, dynamic> json) => IceCream(
        image: json["image"],
        title: json["title"],
        details: json["details"],
        category: json["category"],
        price: int.parse(json["price"]),
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "price": price,
        "details": details,
        "category": category,
      };
}

final flavorList = [
  IceCream(
    category: 'Classic Flavors',
    details:
        'Cold Creamy Ice Cream, like other flavor of ice cream, was originally created by cooling a mixture made of cream, sugar and color...',
    image: "assets/images/strawberry.png",
    title: "Strawberry",
    price: 3000,
  ),
];
