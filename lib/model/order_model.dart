class OrderModel {
  final String totalPrice;
  final String details;
  final String delivered;
  final String operationNumber;
  final String email;
  final String userName;
  final String phoneNumber;
  final String location;

  OrderModel({
    required this.email,
    required this.userName,
    required this.phoneNumber,
    required this.location,
    required this.operationNumber,
    required this.totalPrice,
    required this.details,
    required this.delivered,
  });
}
