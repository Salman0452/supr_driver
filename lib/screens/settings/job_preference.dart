import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supr_driver/app/app_theme.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';

class JobPreferenceScreen extends StatefulWidget {
  const JobPreferenceScreen({Key? key}) : super(key: key);

  @override
  State<JobPreferenceScreen> createState() => _JobPreferenceScreenState();
}

class _JobPreferenceScreenState extends State<JobPreferenceScreen> {
  // Selected delivery type
  String _selectedDeliveryType = 'Food';
  
  // Dropdown selections
  String? _selectedOrderSize = 'Small orders (1-2 items)';
  String? _selectedHandling = 'Fragile items';
  String? _selectedDeliveryTime = '30 mins';
  
  // Dropdown options
  final List<String> _orderSizes = [
    'Small orders (1-2 items)',
    'Medium orders (3-5 items)',
    'Large orders (6+ items)',
    'Any size'
  ];
  
  final List<String> _specialHandling = [
    'Fragile items',
    'Temperature sensitive items',
    'Heavy items (10kg+)',
    'Oversized packages',
    'None'
  ];
  
  final List<String> _deliveryTimes = [
    '15 mins',
    '30 mins',
    '45 mins',
    '60 mins',
    'Any time'
  ];
  
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
            color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Job preference',
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
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Type
              Text(
                'Delivery type',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Delivery type selection buttons row
              Row(
                children: [
                  _buildDeliveryTypeButton('Food', isDarkMode),
                  const SizedBox(width: 12),
                  _buildDeliveryTypeButton('Grocery', isDarkMode),
                  const SizedBox(width: 12),
                  _buildDeliveryTypeButton('Medication', isDarkMode),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Order Size Preference
              Text(
                'Order size preference',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Order size dropdown
              _buildDropdown(
                value: _selectedOrderSize,
                items: _orderSizes,
                onChanged: (value) {
                  setState(() {
                    _selectedOrderSize = value;
                  });
                },
                isDarkMode: isDarkMode,
              ),
              
              const SizedBox(height: 24),
              
              // Special Handling Capabilities
              Text(
                'Special handling capabilities',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Special handling dropdown
              _buildDropdown(
                value: _selectedHandling,
                items: _specialHandling,
                onChanged: (value) {
                  setState(() {
                    _selectedHandling = value;
                  });
                },
                isDarkMode: isDarkMode,
              ),
              
              const SizedBox(height: 24),
              
              // Estimated Delivery Preference
              Text(
                'Estimated delivery preference',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Delivery time dropdown
              _buildDropdown(
                value: _selectedDeliveryTime,
                items: _deliveryTimes,
                onChanged: (value) {
                  setState(() {
                    _selectedDeliveryTime = value;
                  });
                },
                isDarkMode: isDarkMode,
              ),
              
              const SizedBox(height: 40),
              
              // Save button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.PrimaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Save Changes',
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
    );
  }
  
  Widget _buildDeliveryTypeButton(String type, bool isDarkMode) {
    final bool isSelected = _selectedDeliveryType == type;
    
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedDeliveryType = type;
          });
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: isSelected 
                ? AppColors.PrimaryColor
                : isDarkMode ? Colors.grey[800] : Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            border: isSelected
                ? Border.all(color: isDarkMode ? Colors.white : Colors.black, width: 1)
                : null,
          ),
          child: Center(
            child: Text(
              type,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? Colors.black
                    : isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    required bool isDarkMode,
  }) {
    return Container(
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
          value: value,
          icon: const Icon(Icons.arrow_drop_down),
          isExpanded: true,
          dropdownColor: isDarkMode ? AppColors.darkBackgroundColor : Colors.white,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
          ),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
  
  void _saveChanges() {
    // Here you would typically save the preferences to your backend or local storage
    
    // Show success message
    Get.snackbar(
      'Success',
      'Job preferences saved successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.PrimaryColor,
      colorText: Colors.black,
      duration: const Duration(seconds: 2),
    );
  }
}