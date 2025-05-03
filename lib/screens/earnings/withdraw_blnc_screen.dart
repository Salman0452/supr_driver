import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';
import 'package:supr_driver/app/app_theme.dart';


class WithdrawBalanceScreen extends StatefulWidget {
  const WithdrawBalanceScreen({super.key});

  @override
  State<WithdrawBalanceScreen> createState() => _WithdrawBalanceScreenState();
}

class _WithdrawBalanceScreenState extends State<WithdrawBalanceScreen> {
  // Payment Method Selection
  String _selectedPaymentMethod = 'Bank';

  // Controllers for Bank Transfer
  final TextEditingController _bankAmountController = TextEditingController();
  final TextEditingController _accountHolderController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _routingNumberController = TextEditingController();

  // Controllers for UPI Transfer
  final TextEditingController _upiAmountController = TextEditingController();
  final TextEditingController _upiIdController = TextEditingController();
  final TextEditingController _upiNameController = TextEditingController();

  @override
  void dispose() {
    _bankAmountController.dispose();
    _accountHolderController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _routingNumberController.dispose();
    _upiAmountController.dispose();
    _upiIdController.dispose();
    _upiNameController.dispose();
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
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_outlined,
              color: isDarkMode ? Colors.white : Colors.black,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Withdraw Balance',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Available Balance Container
            Container(
              width: double.infinity,
              height: 140,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.PrimaryColor,  // Green start color
                    AppColors.PrimaryColor,  // Green start color
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  // Available Balance text
                  Text(
                    'Available Balance',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF000000),
                    ),
                  ),
                  
                  // Balance amount
                  Text(
                    '₹20,450',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Payment Method Selection
            Text(
              'Payment Method',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Radio Buttons for Payment Method
            Row(
              children: [
                // Bank Transfer Radio
                Radio(
                  value: 'Bank',
                  groupValue: _selectedPaymentMethod,
                  activeColor: isDarkMode ? AppColors.PrimaryColor : Colors.black,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value.toString();
                    });
                  },
                ),
                Text(
                  'Bank Transfer',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                
                const SizedBox(width: 0),
                
                // UPI Radio
                Radio(
                  value: 'UPI',
                  groupValue: _selectedPaymentMethod,
                  activeColor: isDarkMode ? AppColors.PrimaryColor : Colors.black,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value.toString();
                    });
                  },
                ),
                Text(
                  'UPI Transfer',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Form Fields based on selected payment method
            _selectedPaymentMethod == 'Bank' 
                ? _buildBankTransferForm()
                : _buildUpiTransferForm(),
                
            const SizedBox(height: 30),
            
            // Withdraw Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle withdrawal process
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Withdrawal request submitted', style: TextStyle(color: Colors.black),), backgroundColor: AppColors.PrimaryColor,),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.PrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Withdraw',
                  style: TextStyle(
                    color: isDarkMode ? AppColors.SecondaryColor : AppColors.SecondaryColor,
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
  
  // Form for Bank Transfer
  Widget _buildBankTransferForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Amount
        _buildTextField(
          controller: _bankAmountController,
          label: 'Amount',
          hintText: 'Enter amount to withdraw',
          keyboardType: TextInputType.number,
          prefixText: '₹ ',
        ),
        const SizedBox(height: 15),
        
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
          hintText: 'Enter ifsc code',
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
  
  // Form for UPI Transfer
  Widget _buildUpiTransferForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Amount
        _buildTextField(
          controller: _upiAmountController,
          label: 'Amount',
          hintText: 'Enter amount to withdraw',
          keyboardType: TextInputType.number,
          prefixText: '₹ ',
        ),
        const SizedBox(height: 15),
        
        // UPI ID
        _buildTextField(
          controller: _upiIdController,
          label: 'UPI ID',
          hintText: 'Enter your UPI ID (e.g. name@upi)',
        ),
        const SizedBox(height: 15),
        
        // UPI Registered Name
        _buildTextField(
          controller: _upiNameController,
          label: 'UPI Registered Name',
          hintText: 'Enter name registered with UPI',
        ),
      ],
    );
  }
  
  // Common TextField Builder
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? prefixText,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            prefixText: prefixText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}