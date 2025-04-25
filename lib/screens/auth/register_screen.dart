import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supr_driver/app/routes.dart';

import '../../app/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _storeNameController = TextEditingController();
  final _storeAddressController = TextEditingController();
  String? _category = 'Food and Beverage';

  void _onSubmitted(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Navigate to password setup screen with category information
      // Get.toNamed(
      //   Routes.passwordRegisterScreen,
      //   arguments: {
      //     'category': _category,
      //     'fullName': _usernameController.text,
      //     'email': _emailController.text,
      //     'phone': _phoneController.text,
      //     'storeName': _storeNameController.text,
      //     'storeAddress': _storeAddressController.text,
      //   }
      // );
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
            icon: Icon(Icons.chevron_left,size: 30, color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor),
            onPressed: () => {},
          ),
          title: Text(
            'Register your account',
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
                  'Full name',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your full name',
                    prefixIcon: const Icon(Icons.person_outline,),
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
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                Text(
                  'Email',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(Icons.email_outlined),
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
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                Text(
                  'Phone number',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number',
                    prefixIcon: const Icon(Icons.phone_outlined),
                    prefixText: '+91 ',
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
                      return 'Please enter your phone number';
                    }
                    if (value.length != 10) {
                      return 'Phone number must be 10 digits';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                Text(
                  'Category',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // border: Border.all(color: const Color(0xFF898483)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      value: _category,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.category_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF898483)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF898483)),
                        ),
                        contentPadding: EdgeInsets.all(15),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor),
                        ),
                      ),
                      items: [
                        'Food and Beverage',
                        'Grocery',
                        'Pharmacy and Health',
                        'Electronics'
                        'Transportation',
                        'Dining and Entertainment',
                        'Home Services',
                        'Delivery Partner'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _category = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                Text(
                  'Store name',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _storeNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your store name',
                    prefixIcon: const Icon(Icons.store_outlined),
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
                      return 'Please enter your store name';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                Text(
                  'Store address',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _storeAddressController,
                  // maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter your store address',
                    prefixIcon: Icon(Icons.location_on_outlined),
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
                      return 'Please enter your store address';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _onSubmitted(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: isDarkMode ? AppColors.PrimaryColor : AppColors.PrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? AppColors.SecondaryColor : AppColors.SecondaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Sign In option for existing users
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Navigate to login screen
                      // Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
                      Get.offNamed(Routes.loginScreen);
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                        ),
                        children: [
                          const TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
