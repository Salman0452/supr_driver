import 'package:flutter/material.dart';
import '../../Utils/theme_Constants.dart';
import 'package:flutter/services.dart';
import 'package:supr_driver/app/app_theme.dart';
import 'package:get/get.dart';
import 'package:supr_driver/app/routes.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
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
          // surfaceTintColor: Colors.transparent,
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
            'Help Center',
            style: TextStyle(
              color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              height: 30 / 20,
            ),
          ),
          actions: [
          // Chat button
          IconButton(
            icon: Icon(
              Icons.chat_outlined,
              color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
            ),
            onPressed: () {
              Get.toNamed(Routes.supportChat);
            },
          ),
        ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting section
              Text(
                'Hello, Arief!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: isDarkMode ? Colors.white : Color(0xFF2F2F2F),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'What can I help you with today?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: isDarkMode ? Colors.white : Color(0xFF2F2F2F),
                ),
              ),
              const SizedBox(height: 24),

              // Search field
              TextFormField(
                controller: _searchController,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Search for help',
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                  prefixIcon: Icon(Icons.search, color: isDarkMode ? Colors.grey[400] : null),
                  filled: true,
                  fillColor: isDarkMode ? Color(0xFF303030) : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.grey[700]! : Color(0xFF898483),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.grey[700]! : Color(0xFF898483),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: AppColors.PrimaryColor),
                  ),
                  contentPadding: const EdgeInsets.all(15),
                ),
              ),

              const SizedBox(height: 12),
              Text(
                'You can search some keywords from your problem for faster solution you might have.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: isDarkMode ? Colors.grey[300] : Color(0xFF2F2F2F),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),
              Text(
                'Frequently Asked',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: isDarkMode ? Colors.white : Color(0xFF2F2F2F),
                ),
              ),

              const SizedBox(height: 16),

              // FAQ Items
              _buildFAQItem(
                'How do I create an account?',
                'You can create a Smartpay account by: download and open the smartpay application first then select ...',
                isDarkMode,
              ),

              const SizedBox(height: 12),

              _buildFAQItem(
                'How to create a card for transactions?',
                'You can select the create card menu then select "Add New Card" select the continue button then you ...',
                isDarkMode,
              ),

              const SizedBox(height: 12),

              _buildFAQItem(
                'How to Top Up on this App?',
                'Click the Top Up menu then select the amount of money and the method then click the "top up now" button...',
                isDarkMode,
              ),

              const SizedBox(height: 32),

              // Submit Appeal button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle appeal submission
                    Get.toNamed(Routes.appealScreen);
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

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF252525) : Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : const Color(0xFFD7D7D7),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Color(0xFF2F2F2F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            answer,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.grey[400] : Color(0xFF929292),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}