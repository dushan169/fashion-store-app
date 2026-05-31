import 'package:fashion_store_app/controllers/auth_controller.dart';
import 'package:fashion_store_app/view/main_screen.dart';
import 'package:fashion_store_app/view/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'widget/custom_textfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

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
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios,
                    color: isDark ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 20),
              Text('Create Account',
                  style: AppTextStyle.withColour(
                      AppTextStyle.h1, Theme.of(context).textTheme.bodyLarge!.color!)),
              const SizedBox(height: 8),
              Text('Signup to get started',
                  style: AppTextStyle.withColour(AppTextStyle.bodyLarge,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!)),
              const SizedBox(height: 40),
              CustomTextfield(
                label: "Full Name",
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.name,
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter your name";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                label: "Email",
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter your email";
                  if (!GetUtils.isEmail(value)) return "Please enter a valid email";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                label: "Password",
                prefixIcon: Icons.lock_outline,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter your password";
                  if (value.length < 8) return "Password must be at least 8 characters";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                label: "Confirm Password",
                prefixIcon: Icons.lock_outline,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please confirm your password";
                  if (value != _passwordController.text) return "Passwords do not match";
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _authController.isLoading.value ? null : _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryIconTheme.color,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _authController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text("Sign Up",
                          style: AppTextStyle.withColour(
                              AppTextStyle.buttonMedium, Theme.of(context).primaryColor)),
                ),
              )),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: AppTextStyle.withColour(AppTextStyle.bodySmall,
                          isDark ? Colors.grey[400]! : Colors.grey[600]!)),
                  TextButton(
                    onPressed: () => Get.off(() => SigninScreen()),
                    child: Text("Sign In",
                        style: AppTextStyle.withColour(
                            AppTextStyle.buttonMedium, Theme.of(context).primaryColor)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignUp() async {
    final success = await _authController.register(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (success) {
      Get.offAll(() => const MainScreen());
    }
  }
}
