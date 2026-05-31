import 'package:fashion_store_app/controllers/auth_controller.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:fashion_store_app/view/widget/custom_textfield.dart';
import 'package:fashion_store_app/view/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_screen.dart';
import 'sign_up_screen.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
              const SizedBox(height: 40),
              Text(
                "Welcome Back!",
                style: AppTextStyle.withColour(
                  AppTextStyle.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'sign in to continue shopping',
                style: AppTextStyle.withColour(
                  AppTextStyle.bodyLarge,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
              const SizedBox(height: 40),
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
              const SizedBox(height: 20),
              CustomTextfield(
                label: "Password",
                prefixIcon: Icons.lock_outline,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter your password";
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.to(() => ForgotPasswordScreen()),
                  child: Text("Forgot Password?",
                      style: AppTextStyle.withColour(
                          AppTextStyle.buttonMedium, Theme.of(context).primaryColor)),
                ),
              ),
              const SizedBox(height: 24),
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _authController.isLoading.value ? null : _handleSignIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12)),
                  ),
                  child: _authController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text("Sign In",
                          style: AppTextStyle.withColour(
                              AppTextStyle.buttonMedium, Theme.of(context).primaryColor)),
                ),
              )),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                      style: AppTextStyle.withColour(AppTextStyle.bodySmall,
                          isDark ? Colors.grey[400]! : Colors.grey[600]!)),
                  TextButton(
                    onPressed: () => Get.to(() => SignUpScreen()),
                    child: Text("Sign Up",
                        style: AppTextStyle.withColour(
                            AppTextStyle.buttonMedium, Theme.of(context).primaryColor)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignIn() async {
    final success = await _authController.login(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (success) {
      Get.offAll(() => const MainScreen());
    }
  }
}
