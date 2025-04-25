import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../Utils/theme_Constants.dart';
import '../../app/app_theme.dart';
import '../../app/routes.dart';

class PhoneOtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  
  const PhoneOtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<PhoneOtpVerificationScreen> createState() => _PhoneOtpVerificationScreenState();
}

class _PhoneOtpVerificationScreenState extends State<PhoneOtpVerificationScreen> {
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

  // Start a timer to simulate OTP verification process
  void _startVerifyTimer() {
    setState(() {
      _isVerifyingOtp = true;
      _verifyTimeLeft = 3;
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
    });
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Phone verified successfully!', style: TextStyle(color: AppColors.SecondaryColor)),
        backgroundColor: AppColors.PrimaryColor,
      ),
    );
    
    // Navigate to reset password screen
    Get.offNamed(Routes.resetPasswordScreen);
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
      const SnackBar(
        content: Text('OTP resent successfully', style: TextStyle(color: AppColors.SecondaryColor),),
        backgroundColor: AppColors.PrimaryColor,
      ),
    );
    
    // Reset OTP fields
    for (var controller in _otpControllers) {
      controller.clear();
    }
    FocusScope.of(context).requestFocus(_focusNodes[0]);
    
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
            icon: Icon(
              Icons.chevron_left_outlined,
              size: 30,
              color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                
                // Phone icon in a circle
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
                  child: Icon(
                    Icons.phone_android,
                    color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                    size: 50,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                Text(
                  'Verify your phone number',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                
                const SizedBox(height: 15),
                
                Text(
                  'Check your phone messages we have sent a four digit verfication code to\n${widget.phoneNumber}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),

                const SizedBox(height: 40),

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
                        style: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.zero,
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
                            borderSide: BorderSide(color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
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
                          // Move to next field if current field is filled
                          if (value.length == 1 && index < 3) {
                            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                          }
                          
                          // Auto-submit when all fields are filled
                          if (value.length == 1 && index == 3) {
                            bool allFilled = true;
                            for (var controller in _otpControllers) {
                              if (controller.text.isEmpty) {
                                allFilled = false;
                                break;
                              }
                            }
                            if (allFilled && !_isVerifyingOtp) {
                              _verifyOtp();
                            }
                          }
                        },
                      ),
                    );
                  }),
                ),
                
                const SizedBox(height: 20),
                
                // Resend OTP option with timer
                TextButton(
                  onPressed: _resendTimeLeft > 0 ? null : _resendOtp,
                  child: Text(
                    _resendTimeLeft > 0 
                        ? "Didn't receive code? Resend code in ${_resendTimeLeft}s"
                        : 'Resend code',
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
                
                const SizedBox(height: 20),
                
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
                      foregroundColor: isDarkMode ? AppColors.SecondaryColor : AppColors.SecondaryColor,
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
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : const Text(
                            'Verify Code',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Change phone option
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Change phone number',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
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