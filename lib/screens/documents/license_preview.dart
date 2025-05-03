import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supr_driver/app/app_theme.dart';
import 'package:supr_driver/app/routes.dart';

class LicensePreviewScreen extends StatelessWidget {
  const LicensePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // Retrieve the image file from Get arguments
    final File imageFile = Get.arguments['imageFile'];
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
            color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Vehicle Information',
          style: TextStyle(
            color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Preview your driver\'s license',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                ),
              ),
              const SizedBox(height: 24),
              
              // Image Preview Container
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFF898483),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9), // Slightly smaller than the container's border radius
                  child: Image.file(
                    imageFile,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              Text(
                'Provide the correct information on the vehicle you use for delivery.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                ),
              ),
              
              const SizedBox(height: 50),
              
              // Re-upload and Submit buttons row
              Row(
                children: [
                  // Re-upload button
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          // Go back to upload screen and ensure previous image is discarded
                          Get.back();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                          side: BorderSide(color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Re-upload',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Submit button
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleSubmission(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.PrimaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  
  void _handleSubmission(BuildContext context) {
    // Show a success message
    Get.snackbar(
      'Success',
      'License submitted successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.PrimaryColor,
      colorText: Colors.black,
      duration: const Duration(seconds: 2),
    );
    
    // Navigate to the next screen or back to the dashboard
    // For example:
    // Get.offAllNamed(Routes.dashboardScreen);
    
    // Or navigate to another screen in the onboarding process
    Get.toNamed(Routes.licensePlateUploadScreen);
  }
}