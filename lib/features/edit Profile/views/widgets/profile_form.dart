import 'package:fashion_store_app/controllers/auth_controller.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:fashion_store_app/view/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final authController = Get.find<AuthController>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: authController.userName.value);
    emailController = TextEditingController(text: authController.userEmail.value);
    phoneController = TextEditingController(text: authController.userPhone.value);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(
                color: isDark ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
                blurRadius: 8, offset: const Offset(0, 2),
              )],
            ),
            child: CustomTextfield(
              label: 'Full Name',
              prefixIcon: Icons.person_outline,
              controller: nameController,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(
                color: isDark ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
                blurRadius: 8, offset: const Offset(0, 2),
              )],
            ),
            child: CustomTextfield(
              label: 'Email',
              prefixIcon: Icons.email_outlined,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(
                color: isDark ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
                blurRadius: 8, offset: const Offset(0, 2),
              )],
            ),
            child: CustomTextfield(
              label: 'Phone Number',
              prefixIcon: Icons.phone_outlined,
              controller: phoneController,
            ),
          ),
          const SizedBox(height: 32),
          Obx(() => SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: authController.isLoading.value ? null : () async {
                final success = await authController.updateProfile(
                  name: nameController.text,
                  phone: phoneController.text,
                );
                if (success) Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: authController.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text('Save Changes',
                      style: AppTextStyle.withColour(AppTextStyle.buttonMedium, Colors.white)),
            ),
          )),
        ],
      ),
    );
  }
}