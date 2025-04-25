import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:supr_driver/app/app_theme.dart';
import 'package:supr_driver/app/routes.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      description: 'Become the mobile seller and sell to wider customer in comfort.',
      imagePath: 'assets/images/svgs/onboard-img-1.svg',
      isSvg: true,
      word: 'Supr',
    ),
    OnboardingPage(
      description: 'Your Store, your way. Set up your store and start selling with Supr.',
      imagePath: 'assets/images/onboard-img-2.jpeg',
      isSvg: false,
      word: 'Supr',
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    // Auto-scroll to next page after 3 seconds - only for the first page
    Future.delayed(const Duration(seconds: 3), () {
      if (_currentPage == 0 && _pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });

    // Listen to page changes
    _pageController.addListener(() {
      if (_pageController.page != null && _pageController.page!.round() != _currentPage) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  void _navigateToRegister() {
    // Get.offNamed(Routes.registerScreen);
  }

  void _navigateToLogin() {
    // Get.offNamed(Routes.loginScreen);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button at top right
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, right: 25.0),
                child: ElevatedButton(
                  onPressed: _navigateToLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                        width: 1.0,
                      ),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  ),
                  child: const Text(
                    'Skip >',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.0, // line-height 100%
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
              ),
            ),
            
            // Main content area
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),
            
            // Bottom pagination dots
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _buildDot(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image below skip button (not centered)
        Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
          child: page.isSvg
              ? SvgPicture.asset(
                  page.imagePath,
                  width: double.infinity,
                  height: 300,
                )
              : Image.asset(
                  page.imagePath,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
        ),

        // Description below image
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0, left: 25, right: 25),
          child: _buildRichDescription(page.description, page.word),
        ),

        // Create Account and Login buttons only on the second screen
        if (_pages.indexOf(page) == 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                // Create Account button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _navigateToRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PrimaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? AppColors.SecondaryColor : AppColors.SecondaryColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16.0),

                // Login button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _navigateToLogin,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      side: BorderSide(
                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Spacer to push content up
        const Spacer(),
      ],
    );
  }

  Widget _buildRichDescription(String description, String? wordToStyle) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? AppColors.darkTextColor : AppColors.textColor;
    
    if (wordToStyle == null || wordToStyle.isEmpty || !description.contains(wordToStyle)) {
      return Text(
        description,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
          height: 24.0 / 16.0,
          letterSpacing: 0.0,
          color: textColor,
        ),
      );
    }

    final parts = description.split(wordToStyle);
    final textSpans = <InlineSpan>[];

    for (int i = 0; i < parts.length; i++) {
      // Add the regular part
      textSpans.add(
        TextSpan(
          text: parts[i],
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            height: 24.0 / 16.0,
            letterSpacing: 0.0,
            color: textColor,
          ),
        ),
      );

      // Add the styled word (except after the last part)
      if (i < parts.length - 1) {
        textSpans.add(
          TextSpan(
            text: wordToStyle,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,  // Bold for "Supr"
              height: 24.0 / 16.0,
              letterSpacing: 0.0,
              color: textColor,
            ),
          ),
        );
      }
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: textSpans),
    );
  }

  Widget _buildDot(int index) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: _currentPage == index 
            ? (isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor)
            : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingPage {
  final String description;
  final String imagePath;
  final bool isSvg;
  final String word;

  OnboardingPage({
    required this.description,
    required this.imagePath,
    required this.isSvg,
    this.word = '',
  });
}