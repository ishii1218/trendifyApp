class Address {
  final String street;
  final String city;
  final String state;
  final String postalCode;

  Address(
      {required this.street,
      required this.city,
      required this.state,
      required this.postalCode});

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
    };
  }
}
