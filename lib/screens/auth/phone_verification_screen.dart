import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supr_driver/app/routes.dart';

import '../../app/app_theme.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );
  
  // Timer related variables
  Timer? _resendTimer;
  int _resendTimeLeft = 0;
  bool _isVerifyingOtp = false;
  int _verifyTimeLeft = 0;
  Timer? _verifyTimer;

  @override
  void initState() {
    super.initState();
    // Start with initial OTP sent
    _startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _verifyTimer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  // Start a 30-second timer for the resend OTP button
  void _startResendTimer() {
    setState(() {
      _resendTimeLeft = 15;
    });
    
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendTimeLeft > 0) {
          _resendTimeLeft--;
        } else {
          _resendTimer?.cancel();
        }
      });
    });
  }

  // Start a 15-second timer to simulate OTP verification process
  void _startVerifyTimer() {
    setState(() {
      _isVerifyingOtp = true;
      _verifyTimeLeft = 5;
    });
    
    _verifyTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_verifyTimeLeft > 0) {
          _verifyTimeLeft--;
        } else {
          _verifyTimer?.cancel();
          _completeVerification();
        }
      });
    });
  }

  void _completeVerification() {
    setState(() {
      _isVerifyingOtp = false;
      // Get.offNamed(Routes.dashboardScreen);
    });
    
    // Show success message
    Get.snackbar(
      'Success',
      'Phone verified successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.PrimaryColor,
      colorText: AppColors.SecondaryColor,
      duration: const Duration(seconds: 2),
    );
    
    // Navigate to home screen
    // Get.offAllNamed(Routes.homeScreen);
  }

  void _verifyOtp() {
    if (_formKey.currentState!.validate()) {
      String otp = _otpControllers.map((controller) => controller.text).join();
      print('OTP entered: $otp');
      
      // Start verification timer
      _startVerifyTimer();
    }
  }

  void _resendOtp() {
    // In a real app, you would call your backend to resend the OTP
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP resent successfully',style: TextStyle(color: AppColors.SecondaryColor),),
      backgroundColor: AppColors.PrimaryColor,),
    );
    
    // Start the timer
    _startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.chevron_left_outlined,size: 30, color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Account Verification',
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Verify your phone number',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'We have sent a four digit verification code to your phone number. Please enter it below:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 50),

                // OTP input fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 60,
                      height: 60,
                      child: TextFormField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        enabled: !_isVerifyingOtp,
                        style: const TextStyle(fontSize: 24),
                        decoration: InputDecoration(
                          counterText: '',
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.length == 1 && index < 3) {
                            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                          }
                        },
                      ),
                    );
                  }),
                ),
                
                const SizedBox(height: 30),
                
                // Resend OTP option with timer
                TextButton(
                  onPressed: _resendTimeLeft > 0 ? null : _resendOtp,
                  child: Text(
                    _resendTimeLeft > 0 
                        ? "Didn't receive code? Resend code in ${_resendTimeLeft}s"
                        : 'Resend OTP',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: _resendTimeLeft > 0 
                          ? Colors.grey
                          : isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Verify button with loading state
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isVerifyingOtp ? null : _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isVerifyingOtp 
                          ? Colors.grey 
                          : AppColors.PrimaryColor,
                      foregroundColor: AppColors.SecondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: _isVerifyingOtp
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Verifying... ${_verifyTimeLeft}s',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : const Text(
                            'Verify',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
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