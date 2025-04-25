import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:supr_driver/app/routes.dart';

import '../../app/app_theme.dart';

class PasswordRegisterScreen extends StatefulWidget {
  const PasswordRegisterScreen({super.key});

  @override
  State<PasswordRegisterScreen> createState() => _PasswordRegisterScreenState();
}

class _PasswordRegisterScreenState extends State<PasswordRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  
  // Get the category from arguments if available
  String? get _category => Get.arguments?['category'] as String?;

  void _onSavePassword() {
    if (_formKey.currentState!.validate()) {
      // Password saved successfully
      // In a real app, you would save the password to your backend
      
      // Show success message
      Get.snackbar(
        'Success',
        'Password set successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.PrimaryColor,
        colorText: Colors.black,
        duration: const Duration(seconds: 3),
      );
      Get.offAllNamed(Routes.loginScreen);
      
      // Check if user is from Transportation category
      // if (_category == 'Transportation') {
      //   // Navigate to transportation documents screen
      //   Get.offNamed(Routes.transportationDocumentScreen);
      // } if(_category == 'Dining and Entertainment') {
      //   Get.offNamed(Routes.homeServicesDocumentScreen);
      // }
      // else {
      //   // For other categories, navigate to login screen
      //   Get.offAllNamed(Routes.loginScreen);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.chevron_left, size: 30, color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                // Supr logo image
                Image.asset(
                  'assets/images/logo.png',
                  height: 80,
                ),
                const SizedBox(height: 20),
                Text(
                  'Password Registration',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 60),
                
                // Password field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF898483)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF898483)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor),
                        ),
                        contentPadding: const EdgeInsets.all(15),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Confirm Password field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        hintText: 'Re-enter your password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF898483)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF898483)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor),
                        ),
                        contentPadding: const EdgeInsets.all(15),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 50),
                
                // Save Password button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _onSavePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PrimaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Save Password',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or Sign in with',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialLoginButton(
                        icon: 'assets/images/svgs/google_icon.svg',
                        onTap: () {
                          // Handle Google login
                        },
                      ),
                      const SizedBox(width: 24),
                      _socialLoginButton(
                        icon: 'assets/images/svgs/apple_icon.svg',
                        onTap: () {
                          // Handle Apple login
                        },
                      ),
                      const SizedBox(width: 24),
                      _socialLoginButton(
                        icon: 'assets/images/svgs/fb_icon.svg',
                        onTap: () {
                          // Handle Facebook login
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Navigate to registration screen
                        Get.toNamed(Routes.loginScreen);
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                          ),
                          children: [
                            TextSpan(text: 'Already have an account? '),
                            TextSpan(
                              text: 'Sign in',
                              style: TextStyle(
                                color: AppColors.PrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton({required String icon, required VoidCallback onTap}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[300] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            icon,
            height: 24,
          ),
        ),
      ),
    );
  }
}

