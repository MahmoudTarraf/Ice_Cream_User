class SpecialOffer {
  final String image;
  final String title; // Optional title for the offer
  final String details;
  final int newPrice;
  final int oldPrice;
  final String category;
  const SpecialOffer({
    required this.category,
    required this.details,
    required this.image,
    required this.title,
    required this.newPrice,
    required this.oldPrice,
  });
  factory SpecialOffer.fromJson(Map<String, dynamic> json) => SpecialOffer(
        image: json["image"],
        title: json["title"],
        details: json["details"],
        category: json["category"],
        oldPrice: int.parse(json["oldPrice"]),
        newPrice: int.parse(json["newPrice"]),
      );
}

const offersLista = [
  SpecialOffer(
      category: 'Classic Flavors',
      details: 'details',
      title: 'IceCream cone',
      image: 'assets/images/1.jpg',
      newPrice: 3,
      oldPrice: 12),
];
