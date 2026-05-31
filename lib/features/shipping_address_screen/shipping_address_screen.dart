import 'package:fashion_store_app/controllers/auth_controller.dart';
import 'package:fashion_store_app/features/shipping_address_screen/models/address.dart';
import 'package:fashion_store_app/features/shipping_address_screen/repositories/address_repository.dart';
import 'package:fashion_store_app/features/shipping_address_screen/widgets/address_card.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ShippingAddressScreen extends StatelessWidget {
  final AddressRepository _repository = AddressRepository();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final userId = authController.userId ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
        ),
        title: Text('Shipping Address',
            style: AppTextStyle.withColour(AppTextStyle.h3, Theme.of(context).primaryColor)),
        actions: [
          IconButton(
            onPressed: () => _showAddressBottomSheet(context, userId),
            icon: Icon(Icons.add_circle_outline, color: Theme.of(context).primaryColor),
          ),
        ],
      ),
      body: StreamBuilder<List<Address>>(
        stream: _repository.getUserAddresses(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final addresses = snapshot.data ?? [];
          if (addresses.isEmpty) {
            return Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.location_off_outlined, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text('No addresses added yet',
                    style: AppTextStyle.withColour(AppTextStyle.bodyMedium, Colors.grey)),
              ]),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: addresses.length,
            itemBuilder: (context, index) => AddressCard(
              address: addresses[index],
              onEdit: () => _showEditAddressBottomSheet(context, addresses[index]),
              onDelete: () => _showDeleteConfirmation(context, addresses[index].id),
            ),
          );
        },
      ),
    );
  }

  void _showAddressBottomSheet(BuildContext context, String userId) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final labelController = TextEditingController();
    final addressController = TextEditingController();
    final cityController = TextEditingController();
    final stateController = TextEditingController();
    final zipController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Add New Address',
              style: AppTextStyle.withColour(
                  AppTextStyle.h3, Theme.of(context).textTheme.bodyLarge!.color!)),
          const SizedBox(height: 16),
          TextField(controller: labelController,
              decoration: const InputDecoration(labelText: 'Label (e.g. Home)')),
          TextField(controller: addressController,
              decoration: const InputDecoration(labelText: 'Full Address')),
          TextField(controller: cityController,
              decoration: const InputDecoration(labelText: 'City')),
          TextField(controller: stateController,
              decoration: const InputDecoration(labelText: 'State/Province')),
          TextField(controller: zipController,
              decoration: const InputDecoration(labelText: 'Zip Code')),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final address = Address(
                  id: '',
                  userId: userId,
                  label: labelController.text,
                  fullAddress: addressController.text,
                  city: cityController.text,
                  state: stateController.text,
                  zipCode: zipController.text,
                  isDefault: false,
                );
                await _repository.addAddress(address);
                Get.back();
                Get.snackbar('Success', 'Address added!');
              },
              child: const Text('Save Address'),
            ),
          ),
        ]),
      ),
      isScrollControlled: true,
    );
  }

 void _showEditAddressBottomSheet(BuildContext context, Address address) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final labelController = TextEditingController(text: address.label);
  final addressController = TextEditingController(text: address.fullAddress);
  final cityController = TextEditingController(text: address.city);
  final stateController = TextEditingController(text: address.state);
  final zipController = TextEditingController(text: address.zipCode);

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Edit Address',
              style: AppTextStyle.withColour(
                  AppTextStyle.h3, Theme.of(context).textTheme.bodyLarge!.color!)),
          const SizedBox(height: 16),
          TextField(controller: labelController,
              decoration: const InputDecoration(labelText: 'Label (e.g. Home)')),
          TextField(controller: addressController,
              decoration: const InputDecoration(labelText: 'Full Address')),
          TextField(controller: cityController,
              decoration: const InputDecoration(labelText: 'City')),
          TextField(controller: stateController,
              decoration: const InputDecoration(labelText: 'State/Province')),
          TextField(controller: zipController,
              decoration: const InputDecoration(labelText: 'Zip Code')),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await _firestore
                    .collection('addresses')
                    .doc(address.id)
                    .update({
                  'label': labelController.text,
                  'fullAddress': addressController.text,
                  'city': cityController.text,
                  'state': stateController.text,
                  'zipCode': zipController.text,
                });
                Get.back();
                Get.snackbar('Success', 'Address updated!');
              },
              child: const Text('Update Address'),
            ),
          ),
        ]),
      ),
    ),
    isScrollControlled: true,
  );
}

  void _showDeleteConfirmation(BuildContext context, String addressId) {
    Get.dialog(AlertDialog(
      title: const Text('Delete Address'),
      content: const Text('Are you sure you want to delete this address?'),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        TextButton(
          onPressed: () async {
            await _repository.deleteAddress(addressId);
            Get.back();
            Get.snackbar('Success', 'Address deleted');
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    ));
  }
}
