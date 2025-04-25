import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Utils/theme_Constants.dart';
import '../../app/app_theme.dart';
import 'email_verification_screen.dart';
import 'phone_otp_verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  bool _isEmail = true; // Start with email as default
  
  // Track if user has explicitly chosen input type
  bool _hasUserInteracted = false;

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    super.dispose();
  }

  // Improved input type detection
  void _detectInputType(String value) {
    // Only change type if user hasn't explicitly selected a type yet
    // or if they specifically include @ for email
    if (!_hasUserInteracted || value.contains('@')) {
      final bool emailPattern = value.contains('@');
      final bool allDigits = RegExp(r'^[0-9]*$').hasMatch(value);
      
      setState(() {
        // If there's an @ sign, it's definitely an email
        if (emailPattern) {
          _isEmail = true;
          _hasUserInteracted = true;
        } 
        // If there are only digits and length is starting to look like a phone number
        else if (allDigits && value.length >= 3) {
          _isEmail = false;
          _hasUserInteracted = true;
        }
        // Don't change type for short inputs or if they might be typing an email
      });
    }
  }

  // User can explicitly select input type
  void _setInputType(bool isEmail) {
    setState(() {
      _isEmail = isEmail;
      _hasUserInteracted = true;
      
      // Clear field when switching types
      _emailOrPhoneController.clear();
      
      // Request focus to the text field
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  // Validate the input
  String? _validateEmailOrPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email or phone number';
    }

    if (_isEmail) {
      // Validate email
      final bool validEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
      if (!validEmail) {
        return 'Please enter a valid email address';
      }
    } else {
      // Validate phone - assuming Indian phone numbers
      final bool validPhone = RegExp(r'^[0-9]{10}$').hasMatch(value);
      if (!validPhone) {
        return 'Please enter a valid 10-digit phone number';
      }
    }
    return null;
  }

  final FocusNode _focusNode = FocusNode();

  void _onContinue() {
    if (_formKey.currentState!.validate()) {
      String inputValue = _emailOrPhoneController.text.trim();
      
      // Navigate to the appropriate verification screen based on input type
      if (_isEmail) {
        //Navigate to email verification screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmailVerificationScreen(email: inputValue),
          ),
        );
      } else {
        // For phone number, we already have +91 in the UI
        String formattedPhone = '+91 $inputValue';
        
        //Navigate to phone OTP verification screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhoneOtpVerificationScreen(phoneNumber: formattedPhone),
          ),
        );
      }
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
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
          title: Text(
            'Forgot Password',
            style: TextStyle(
              color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
              fontSize: 20,
              height: 30/20,
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  
                  // Circular container with question mark
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: ThemeConstants.primaryColor.withOpacity(0.1),
                      border: Border.all(
                        color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.question_mark,
                        color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                        size: 50,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Reset password text
                  Text(
                    "It's Okay! Reset your password",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Email/Phone input field
                  TextFormField(
                    controller: _emailOrPhoneController,
                    focusNode: _focusNode,
                    keyboardType: _isEmail 
                        ? TextInputType.emailAddress 
                        : TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: _isEmail 
                          ? 'Enter your Email Address' 
                          : 'Enter your Phone Number',
                      prefixIcon: _isEmail 
                          ? Icon(Icons.alternate_email, color: AppColors.SecondaryColor,)
                          : null,
                      prefixText: _isEmail ? null : '+91 ',
                      prefixStyle: TextStyle(
                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
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
                    onChanged: _detectInputType,
                    validator: _validateEmailOrPhone,
                    inputFormatters: _isEmail 
                        ? null 
                        : [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // Toggle text to switch between email and phone
                  TextButton(
                    onPressed: () {
                      _setInputType(!_isEmail);
                    },
                    child: Text(
                      _isEmail 
                          ? 'Use phone number instead' 
                          : 'Use email address instead',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _onContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.PrimaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? AppColors.SecondaryColor : AppColors.SecondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}