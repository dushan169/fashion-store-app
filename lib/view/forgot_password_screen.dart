import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:fashion_store_app/view/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fashion_store_app/controllers/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //back button
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              //reset password text
              Text(
                'Reset Password',
                style: AppTextStyle.withColour(
                  AppTextStyle.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Enter your email to reset your password",
                style: AppTextStyle.withColour(
                  AppTextStyle.bodyLarge,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
              const SizedBox(height: 40),
              //email field
               CustomTextfield(
                label: "Email",
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (!GetUtils.isEmail(value)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),
              //send reset link button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
  if (_emailController.text.isEmpty) {
    Get.snackbar('Error', 'Please enter your email!');
    return;
  }
  if (!GetUtils.isEmail(_emailController.text)) {
    Get.snackbar('Error', 'Please enter a valid email!');
    return;
  }
  final authController = Get.find<AuthController>();
  final success = await authController.sendPasswordResetEmail(
    _emailController.text,
  );
  if (success) {
    _showSuccessDialog(context);
  }
},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryIconTheme.color,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Send Reset Link",
                    style: AppTextStyle.withColour(
                      AppTextStyle.buttonMedium,
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
    );
  }
  //show success dialog
  void _showSuccessDialog(BuildContext context){
    Get.dialog(
      AlertDialog(
        title: Text(
          'Check Your Email',
          style: AppTextStyle.h3,
        ),
        content: Text(
          'A password reset link has been sent to ${_emailController.text}. Please check your email to reset your password.',
          style: AppTextStyle.bodySmall,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "OK",
              style: AppTextStyle.withColour(
                AppTextStyle.buttonMedium,
                Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}