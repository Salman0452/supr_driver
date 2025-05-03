import 'package:flutter/material.dart';
import '../../Utils/theme_Constants.dart';
import 'package:supr_driver/app/app_theme.dart';
import 'package:flutter/services.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedPaymentPreference = 'Automatic';
  final List<String> _paymentPreferences = ['Automatic', 'Manual', 'Weekly', 'Monthly'];

  // Controllers for text fields
  final TextEditingController _accountHolderController = TextEditingController(text: "John Doe");
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _routingNumberController = TextEditingController();

  @override
  void dispose() {
    _accountHolderController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _routingNumberController.dispose();
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
          backgroundColor: isDarkMode ? Theme.of(context).appBarTheme.backgroundColor : ThemeConstants.scaffoldBackgroundColor,
          // surfaceTintColor: Colors.transparent,
          // systemOverlayStyle: isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_outlined,
              color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Payment method',
            style: TextStyle(
              color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bank Account Information Section
            Text(
              'Bank Account Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            
            // Account Holder Name
            _buildTextField(
              controller: _accountHolderController,
              label: 'Account Holder Name',
              hintText: 'Enter account holder name',
            ),
            const SizedBox(height: 15),
            
            // Bank Name
            _buildTextField(
              controller: _bankNameController,
              label: 'Bank Name',
              hintText: 'Enter bank name',
            ),
            const SizedBox(height: 15),
            
            // Account Number
            _buildTextField(
              controller: _accountNumberController,
              label: 'Account Number',
              hintText: 'Enter account number',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            
            // Routing Number
            _buildTextField(
              controller: _routingNumberController,
              label: 'IFSC Code',
              hintText: 'Enter routing number',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            
            // Add Another Payment Method Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    // Handle adding another payment method
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 16,
                      color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                    ),
                  ),
                  label: Text(
                    'Add another payment method',
                    style: TextStyle(
                      color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            
            // Payment Preferences Section
            Text(
              'Payment preferences',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Payment Frequency',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              ),
            ),
            const SizedBox(height: 10),
            
            // Payment Preference Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDarkMode ? Colors.grey[700]! : Colors.grey.shade300,
                ),
                color: isDarkMode ? Color(0xFF303030) : Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedPaymentPreference,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, 
                      color: isDarkMode ? Colors.white70 : null),
                  dropdownColor: isDarkMode ? Color(0xFF303030) : Colors.white,
                  items: _paymentPreferences.map((String preference) {
                    return DropdownMenuItem<String>(
                      value: preference,
                      child: Text(
                        preference,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPaymentPreference = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // Save Changes Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle save changes
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Payment method saved'),
                      backgroundColor: AppColors.PrimaryColor,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.PrimaryColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Save Changes',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
            color: isDarkMode ? Colors.white : Color(0xFF000000),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFF303030) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isDarkMode ? [] : [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                // color: isDarkMode ? Colors.grey[400] : Colors.grey.shade400,
                fontFamily: 'Poppins',
                fontSize: 15,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDarkMode ? Colors.grey[700]! : Colors.grey.shade200,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDarkMode ? Colors.grey[700]! : Colors.grey.shade200,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: (BorderSide(color: isDarkMode? AppColors.PrimaryColor : AppColors.SecondaryColor)),
              ),
              filled: true,
              fillColor: isDarkMode ? Color(0xFF303030) : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}