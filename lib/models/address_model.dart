
class AddressModel {
  final String address;
  AddressModel({
    required this.address,
  });

  Map<String, dynamic> getJson() {
    return {
      'address': address,
    };
  }
  static String collectionName = 'address';
}
