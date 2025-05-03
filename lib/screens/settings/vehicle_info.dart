import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supr_driver/app/app_theme.dart';
import 'package:intl/intl.dart';

class VehicleInfoScreenSettings extends StatefulWidget {
  const VehicleInfoScreenSettings({super.key});

  @override
  State<VehicleInfoScreenSettings> createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreenSettings> {
  final _formKey = GlobalKey<FormState>();
  final _licensePlateController = TextEditingController();
  final _licenseExpiryController = TextEditingController();
  final _insuranceExpiryController = TextEditingController();
  
  String? _selectedVehicleType;
  File? _licenseImage;
  File? _insuranceImage;
  final ImagePicker _picker = ImagePicker();
  
  final List<String> _vehicleTypes = [
    'Bicycle',
    'Motorcycle',
    'Car',
    'SUV',
    'Van',
    'Mini Bus',
    'Truck'
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with default values if needed
    _selectedVehicleType = _vehicleTypes[0];
  }

  @override
  void dispose() {
    _licensePlateController.dispose();
    _licenseExpiryController.dispose();
    _insuranceExpiryController.dispose();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    try {
      if (Platform.isAndroid) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.camera,
          Permission.storage,
        ].request();
        
        if (statuses[Permission.camera] != PermissionStatus.granted ||
            statuses[Permission.storage] != PermissionStatus.granted) {
          Get.snackbar(
            'Permission Error',
            'Camera and storage permissions are required.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        }
      } else if (Platform.isIOS) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.camera,
          Permission.photos,
        ].request();
        
        if (statuses[Permission.camera] != PermissionStatus.granted ||
            statuses[Permission.photos] != PermissionStatus.granted) {
          Get.snackbar(
            'Permission Error',
            'Camera and photo library permissions are required.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        }
      }
    } catch (e) {
      debugPrint('Error requesting permissions: $e');
    }
  }

  Future<void> _showImageSourceActionSheet(bool isLicense) async {
    await _requestPermissions();
    
    if (!mounted) return;
    
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: isDarkMode ? AppColors.darkBackgroundColor : AppColors.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Image Source',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageSourceOption(
                      context: context,
                      icon: Icons.camera_alt_outlined,
                      label: 'Camera',
                      onTap: () {
                        _getImage(ImageSource.camera, isLicense);
                        Navigator.of(context).pop();
                      },
                    ),
                    _buildImageSourceOption(
                      context: context,
                      icon: Icons.photo_library_outlined,
                      label: 'Gallery',
                      onTap: () {
                        _getImage(ImageSource.gallery, isLicense);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSourceOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.PrimaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 30,
                color: isDarkMode ? AppColors.SecondaryColor : AppColors.SecondaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage(ImageSource source, bool isLicense) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1200,
        maxHeight: 1200,
      );
      
      if (pickedFile != null) {
        setState(() {
          if (isLicense) {
            _licenseImage = File(pickedFile.path);
          } else {
            _insuranceImage = File(pickedFile.path);
          }
        });
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final DateTime now = DateTime.now();
    final DateTime initialDate = controller.text.isEmpty 
        ? now 
        : DateFormat('dd-MM-yyyy').parse(controller.text);
    
    final ThemeData theme = Theme.of(context).copyWith(
      colorScheme: isDarkMode 
          ? ColorScheme.dark(
              primary: AppColors.PrimaryColor,
              onPrimary: Colors.black,
              surface: AppColors.darkBackgroundColor,
              onSurface: AppColors.lightSecondaryColor,
            )
          : ColorScheme.light(
              primary: AppColors.PrimaryColor, 
              onPrimary: Colors.black,
              onSurface: AppColors.SecondaryColor,
            ),
      dialogBackgroundColor: isDarkMode ? AppColors.darkBackgroundColor : Colors.white,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
        ),
      ),
    );
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: theme,
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Vehicle Type
                Text(
                  'Vehicle Type',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF898483),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: InputBorder.none,
                      ),
                      value: _selectedVehicleType,
                      icon: const Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                      ),
                      items: _vehicleTypes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedVehicleType = value;
                        });
                      },
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // License Plate Number
                Text(
                  'License Plate Number',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _licensePlateController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    hintText: 'Enter license plate number',
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
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your license plate number';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Driver's License
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Driver\'s License',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _showImageSourceActionSheet(true),
                      icon: Icon(
                        Icons.camera_alt,
                        color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                      ),
                    ),
                  ],
                ),
                
                // Display license image if available
                if (_licenseImage != null) ...[
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        _licenseImage!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
                
                const SizedBox(height: 20),
                
                // Expiry date
                Text(
                  'Expiry Date',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _licenseExpiryController,
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    hintText: 'Select expiry date',
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
                    suffixIcon: IconButton(
                      onPressed: () => _selectDate(context, _licenseExpiryController),
                      icon: Icon(
                        Icons.calendar_today,
                        color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an expiry date';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Verification Status
                Text(
                  'Verification Status',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'Unverified',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.help_outline,
                      color: Colors.red,
                      size: 18,
                    ),
                    Tooltip(
                      message: 'Your documents are pending verification by our team.',
                      triggerMode: TooltipTriggerMode.tap,
                      child: Icon(
                        Icons.info_outline,
                        color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Vehicle Insurance Proof
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Vehicle Insurance Proof',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _showImageSourceActionSheet(false),
                      icon: Icon(
                        Icons.camera_alt,
                        color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                      ),
                    ),
                  ],
                ),
                
                // Display insurance image if available
                if (_insuranceImage != null) ...[
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        _insuranceImage!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
                
                const SizedBox(height: 20),
                
                // Insurance Expiry date
                Text(
                  'Expiry Date',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _insuranceExpiryController,
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    hintText: 'Select expiry date',
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
                    suffixIcon: IconButton(
                      onPressed: () => _selectDate(context, _insuranceExpiryController),
                      icon: Icon(
                        Icons.calendar_today,
                        color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an expiry date';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 30),
                
                // Save button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save vehicle information
                        Get.snackbar(
                          'Success',
                          'Vehicle information saved!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.PrimaryColor,
                          colorText: Colors.black,
                          duration: const Duration(seconds: 2),
                        );
                      }
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
                      'Save changes',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
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
}