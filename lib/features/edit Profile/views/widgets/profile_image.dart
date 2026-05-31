import 'package:fashion_store_app/controllers/auth_controller.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authController = Get.find<AuthController>();

    return Center(
      child: Stack(
        children: [
          Obx(() {
            final photoUrl = authController.userPhotoUrl.value;
            return Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
                image: DecorationImage(
                  image: photoUrl.isNotEmpty
                      ? NetworkImage(photoUrl)
                      : const AssetImage('assets/images/avatar.jpg')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _showImagePickerBottomSheet(context, isDark),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

Future<void> _pickAndUploadImage(ImageSource source) async {
  final authController = Get.find<AuthController>();
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source, imageQuality: 70);
  if (pickedFile == null) return;

  try {
    Get.snackbar('Uploading', 'Please wait...');
    final bytes = await pickedFile.readAsBytes();

    final uri = Uri.parse(
        'https://api.cloudinary.com/v1_1/dfopqot5q/image/upload');
    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = 'fashion_store_unsigned'
      ..files.add(http.MultipartFile.fromBytes('file', bytes,
          filename: 'profile.jpg'));

    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    final jsonData = jsonDecode(responseData);
    final url = jsonData['secure_url'];

    await authController.updateProfile(
      name: authController.userName.value,
      phone: authController.userPhone.value,
      photoUrl: url,
    );
    Get.back();
    Get.snackbar('Success', 'Profile picture updated!');
  } catch (e) {
    Get.snackbar('Error', 'Failed to upload: $e');
  }
}

  void _showImagePickerBottomSheet(BuildContext context, bool isDark) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[700] : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text('Change Profile Picture',
                style: AppTextStyle.withColour(
                    AppTextStyle.h3, Theme.of(context).textTheme.bodyLarge!.color!)),
            const SizedBox(height: 24),
            _buildOptionTile(context, 'Take Photo', Icons.camera_alt_outlined,
                () => _pickAndUploadImage(ImageSource.camera), isDark),
            const SizedBox(height: 16),
            _buildOptionTile(context, 'Choose from Gallery', Icons.photo_library_outlined,
                () => _pickAndUploadImage(ImageSource.gallery), isDark),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context, String title, IconData icon,
      VoidCallback onTap, bool isDark) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 24),
            const SizedBox(width: 16),
            Text(title,
                style: AppTextStyle.withColour(AppTextStyle.bodyMedium,
                    Theme.of(context).textTheme.bodyLarge!.color!)),
            const Spacer(),
            Icon(Icons.arrow_forward_ios,
                color: isDark ? Colors.grey[400] : Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}