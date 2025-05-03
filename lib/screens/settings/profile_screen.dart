import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import '../../Utils/theme_Constants.dart';
import 'package:supr_driver/app/routes.dart';
import 'package:supr_driver/app/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80, // Add reasonable quality for profile pictures
        maxWidth: 800,    // Limit dimensions to avoid huge images
      );
      
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      // Handle exception with user feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            source == ImageSource.camera
                ? 'Failed to access camera. Please check permissions.'
                : 'Failed to access gallery. Please check permissions.',
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: Colors.red,
        ),
      );
      print('Error picking image: $e');
    }
  }

  void _showImageSourceActionSheet() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: isDarkMode ? Color(0xFF303030) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Add a header with close icon
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 5, 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: isDarkMode ? Colors.white70 : Color(0xFF000000).withOpacity(0.7),
                            size: 22,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    Text(
                      'Select Image',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: isDarkMode ? Colors.white : Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.photo_library_outlined, color: AppColors.PrimaryColor),
                title: Text(
                  'Gallery',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    height: 21/14,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? Colors.white : Color(0xFF000000).withOpacity(0.7)
                  ),
                ),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera_outlined, color: AppColors.PrimaryColor),
                title: Text(
                  'Camera',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    height: 21/14,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? Colors.white : Color(0xFF000000).withOpacity(0.7),
                  ),
                ),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          systemOverlayStyle: isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_outlined,
              color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Profile',
            style: TextStyle(
              color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile picture with camera icon
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDarkMode ? Colors.grey[800] : Colors.grey.shade200,
                          image: _imageFile != null 
                              ? DecorationImage(
                                  image: FileImage(_imageFile!),
                                  fit: BoxFit.cover,
                                )
                              : const DecorationImage(
                                  image: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.PrimaryColor,
                            border: Border.all(
                              color: isDarkMode ? Colors.grey[900]! : Colors.white,
                              width: 2,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                              size: 18,
                            ),
                            padding: EdgeInsets.zero,
                            onPressed: _showImageSourceActionSheet,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 10),
                
                // User name and verification
                Center(
                  child: Column(
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                          height: 30/20
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.PrimaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified_outlined,
                              color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Verified',
                              style: TextStyle(
                                fontSize: 13,
                                height: 21/14,
                                fontWeight: FontWeight.w400,
                                color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Personal Information header
                Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: 16,
                    height: 24/16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                  ),
                ),
                
                const SizedBox(height: 15),
                
                // Profile information list tiles
                Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Column(
                    children: [
                      _buildInfoListTile(
                        icon: Icons.person_outline,
                        title: 'Full Name',
                        subtitle: 'John Doe',
                        isDarkMode: isDarkMode,
                        onTap: () {
                          // Handle name update
                        },
                      ),
                      _buildInfoListTile(
                        icon: Icons.email_outlined,
                        title: 'Email',
                        subtitle: 'johndoe@example.com',
                        isDarkMode: isDarkMode,
                        onTap: () {
                          // Handle email update
                        },
                      ),
                      _buildInfoListTile(
                        icon: Icons.phone_outlined,
                        title: 'Phone',
                        subtitle: '+91 3456789000',
                        isDarkMode: isDarkMode,
                        onTap: () {
                          // Handle phone update
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.editProfileScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PrimaryColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // Helper method to build consistent info list tiles
  Widget _buildInfoListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDarkMode,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      leading: Icon(
        icon,
        color: isDarkMode ? Colors.white70 : ThemeConstants.textSecondary,
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          height: 21/14,
          fontWeight: FontWeight.w400,
          color: isDarkMode ? Colors.grey[400] : Color(0xFF1E1E1E),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          height: 30/16,
          fontWeight: FontWeight.w400,
          color: isDarkMode ? Colors.white : Color(0xFF1E1E1E),
        ),
      ),
      onTap: onTap,
    );
  }
}
