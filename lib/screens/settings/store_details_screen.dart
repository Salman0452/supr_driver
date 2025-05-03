import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import '../../Utils/theme_Constants.dart';
import 'package:supr_driver/app/routes.dart';
import 'package:supr_driver/app/app_theme.dart';

class StoreDetailsScreen extends StatefulWidget {
  const StoreDetailsScreen({super.key});

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetailsScreen> {
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
            'Store Details',
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
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile information list tiles
                Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Column(
                    children: [
                      _buildInfoListTile(
                        icon: Icons.person_outline,
                        title: 'Store Name',
                        subtitle: 'John Doe',
                        isDarkMode: isDarkMode,
                        onTap: () {
                          // Handle name update
                        },
                      ),
                      _buildInfoListTile(
                        icon: Icons.category_outlined,
                        title: 'Store Category',
                        subtitle: 'Food',
                        isDarkMode: isDarkMode,
                        onTap: () {
                          // Handle email update
                        },
                      ),
                      _buildInfoListTile(
                        icon: Icons.phone_outlined,
                        title: 'Store Contact',
                        subtitle: '+91 3456789000',
                        isDarkMode: isDarkMode,
                        onTap: () {
                          // Handle phone update
                        },
                      ),
                      _buildInfoListTile(
                        icon: Icons.store_outlined,
                        title: 'Store Address',
                        subtitle: '17, Lahore Pune road',
                        isDarkMode: isDarkMode,
                        onTap: () {
                          // Handle address update
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
                      Get.toNamed(Routes.editStoreDetails);
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
  
  // Helper method for consistent list tiles
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
