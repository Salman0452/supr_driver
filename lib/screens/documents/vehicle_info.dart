import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:supr_driver/app/app_theme.dart';
import 'package:supr_driver/app/routes.dart';

class VehicleInfoScreen extends StatefulWidget {
  const VehicleInfoScreen({super.key});

  @override
  State<VehicleInfoScreen> createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _plateNumberController = TextEditingController();
  int _selectedVehicleType = -1; // No selection initially

  final List<Map<String, dynamic>> _vehicleTypes = [
    {'name': 'Bicycle', 'icon': Icons.pedal_bike},
    {'name': 'Car', 'icon': Icons.directions_car},
    {'name': 'Mini Bus', 'icon': Icons.directions_bus},
    {'name': 'Van', 'icon': Icons.airport_shuttle},
  ];

  void _onVerify() {
    if (_formKey.currentState!.validate() && _selectedVehicleType != -1) {
      // Process the data
      Get.snackbar(
        'Success',
        'Vehicle information submitted!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.PrimaryColor,
        colorText: Colors.black,
        duration: const Duration(seconds: 2),
      );
      
      // Navigate to next screen or dashboard
      Get.toNamed(Routes.licenseUploadScreen);
    } else if (_selectedVehicleType == -1) {
      Get.snackbar(
        'Error',
        'Please select a vehicle type',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
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
          elevation: 0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 30,
              color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Provide your vehicle information',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Provide the necessary information on the vehicle you use for delivery.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                
                // Vehicle Type Selection
                Text(
                  'Vehicle Type',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 15),
                
                // Vehicle type icons grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: _vehicleTypes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedVehicleType = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedVehicleType == index 
                              ? AppColors.PrimaryColor 
                              : isDarkMode ? Colors.grey[800] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          border: _selectedVehicleType == index
                              ? Border.all(color: isDarkMode ? Colors.white : Colors.black, width: 2)
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _vehicleTypes[index]['icon'],
                              size: 32,
                              color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _vehicleTypes[index]['name'],
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 30),
                
                // License Plate field
                Text(
                  'License Plate',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _plateNumberController,
                  decoration: InputDecoration(
                    hintText: 'Enter vehicle license plate',
                    prefixIcon: const Icon(Icons.text_snippet_outlined),
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
                      return 'Please enter your license plate number';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Upload Documents field (navigation field)
                InkWell(
                  onTap: () {
                    // Navigate to document upload screen
                    Get.toNamed(Routes.licenseUploadScreen);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF898483)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.file_copy_outlined),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Upload Documents',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 50),
                
                // Verify Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _onVerify,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PrimaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}