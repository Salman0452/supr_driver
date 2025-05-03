import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';
import 'package:get/get.dart';
import 'package:supr_driver/app/routes.dart';
import 'package:supr_driver/app/app_theme.dart';

class AppealScreen extends StatefulWidget {
  const AppealScreen({Key? key}) : super(key: key);

  @override
  State<AppealScreen> createState() => _AppealScreenState();
}

class _AppealScreenState extends State<AppealScreen> {
  final TextEditingController _appealTypeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _referenceIdController = TextEditingController();
  final TextEditingController _contactInfoController = TextEditingController();

  final List<String> appealTypes = [
    'Delivery dispute',
    'Late delivery penalty appeal',
    'Account suspension',
    'Payment/delivery fee issue',
    'Reported unfairly by user or seller',
  ];

  @override
  void dispose() {
    _appealTypeController.dispose();
    _reasonController.dispose();
    _referenceIdController.dispose();
    _contactInfoController.dispose();
    super.dispose();
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
          backgroundColor: isDarkMode ? Theme.of(context).appBarTheme.backgroundColor : ThemeConstants.scaffoldBackgroundColor,
          // systemOverlayStyle: isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
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
            'Submit an Appeal',
            style: TextStyle(
              color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              height: 30 / 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Appeal Type
              _buildSectionLabel('Appeal Type'),
              const SizedBox(height: 8),
              _buildSelectField(
                controller: _appealTypeController,
                hintText: "Select appeal type",
                onTap: () => _showAppealTypeOptions(),
              ),
              const SizedBox(height: 20),

              // Reason for Appeal
              _buildSectionLabel('Reason for Appeal'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _reasonController,
                hintText: "Explain your issue in detail...",
                maxLines: 5,
              ),
              const SizedBox(height: 20),

              // Reference / Order ID
              _buildSectionLabel('Reference / Order ID'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _referenceIdController,
                hintText: "Enter order ID or reference number",
              ),
              const SizedBox(height: 20),

              // Contact Info
              _buildSectionLabel('Contact Info'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _contactInfoController,
                hintText: "Email or phone number where we can reach you",
              ),
              const SizedBox(height: 40),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _submitAppeal();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.PrimaryColor,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Submit Ticket',
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
    );
  }

  // Section label
  Widget _buildSectionLabel(String label) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
        color: isDarkMode ? Colors.white : const Color(0xFF2F2F2F),
      ),
    );
  }

  // Text Field
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
        ),
        filled: true,
        fillColor: isDarkMode ? const Color(0xFF303030) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  // Select field
  Widget _buildSelectField({
    required TextEditingController controller,
    required String hintText,
    required VoidCallback onTap,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF303030) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                controller.text.isEmpty ? hintText : controller.text,
                style: TextStyle(
                  color: controller.text.isEmpty
                      ? (isDarkMode ? Colors.grey[400] : Colors.grey[600])
                      : (isDarkMode ? Colors.white : Colors.black),
                ),
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  // Show appeal type options dialog
  void _showAppealTypeOptions() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: isDarkMode ? const Color(0xFF303030) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Appeal Type",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: appealTypes.length,
                    separatorBuilder: (context, index) => Divider(
                      color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          appealTypes[index],
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _appealTypeController.text = appealTypes[index];
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Submit appeal
  void _submitAppeal() {
    final isValid = _validateFields();
    
    if (isValid) {
      // Show success message
      Get.snackbar(
        'Success',
        'Your appeal has been submitted. We will get back to you soon.',
        backgroundColor: AppColors.PrimaryColor,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(15),
        duration: const Duration(seconds: 3),
      );
      
      // Return to previous screen after a short delay
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }

  // Validate fields
  bool _validateFields() {
    if (_appealTypeController.text.isEmpty) {
      _showErrorSnackbar('Please select an appeal type');
      return false;
    }
    
    if (_reasonController.text.isEmpty) {
      _showErrorSnackbar('Please provide a reason for your appeal');
      return false;
    }
    
    if (_referenceIdController.text.isEmpty) {
      _showErrorSnackbar('Please enter a reference or order ID');
      return false;
    }
    
    if (_contactInfoController.text.isEmpty) {
      _showErrorSnackbar('Please provide your contact information');
      return false;
    }
    
    return true;
  }

  // Show error snackbar
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(15),
    );
  }
}
