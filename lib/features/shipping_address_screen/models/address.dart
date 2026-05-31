import 'package:cloud_firestore/cloud_firestore.dart';

enum AddressType { home, office, other }

class Address {
  final String id;
  final String userId;
  final String label;
  final String fullAddress;
  final String city;
  final String state;
  final String zipCode;
  final bool isDefault;
  final AddressType type;

  const Address({
    required this.id,
    required this.userId,
    required this.label,
    required this.fullAddress,
    required this.city,
    required this.state,
    required this.zipCode,
    this.isDefault = false,
    this.type = AddressType.home,
  });

  String get typeString => type.name;
  String get fullDetails => '$fullAddress, $city, $state $zipCode';

  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'label': label,
        'fullAddress': fullAddress,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'isDefault': isDefault,
        'type': type.name,
        'createdAt': FieldValue.serverTimestamp(),
      };

  factory Address.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Address(
      id: doc.id,
      userId: data['userId'] ?? '',
      label: data['label'] ?? '',
      fullAddress: data['fullAddress'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      zipCode: data['zipCode'] ?? '',
      isDefault: data['isDefault'] ?? false,
      type: AddressType.values.firstWhere(
        (t) => t.name == data['type'],
        orElse: () => AddressType.home,
      ),
    );
  }
}
