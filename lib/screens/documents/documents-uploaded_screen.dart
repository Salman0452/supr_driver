import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../Utils/theme_Constants.dart';
import '../../app/app_theme.dart';
import '../../app/routes.dart';

class DocumentsUploadedScreen extends StatelessWidget {
  const DocumentsUploadedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_outlined,
              color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // No title in AppBar
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Centered content with some space on top
              const SizedBox(height: 30),
              
              // Tick icon in a circle
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.check,
                  color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                  size: 60,
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Password Changed title
              Text(
                "Documents Uploaded",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Success message
              Text(
                "All documents has been uploaded successfully!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Login instruction
              const Text(
                "Now proceed to login.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF898483),
                ),
              ),
              
              const Spacer(),
              // Login button - at the bottom
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to login screen
                    Get.offAllNamed(Routes.loginScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.PrimaryColor,
                    foregroundColor: AppColors.SecondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}