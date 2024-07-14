class User {
  String userName;
  String? email;
  String phoneNumber;
  String location;
  String? image;
  final String points;
  final String totalPurchases;

  User({
    required this.points,
    required this.totalPurchases,
    required this.email,
    required this.location,
    required this.userName,
    required this.phoneNumber,
    this.image,
  });
}
