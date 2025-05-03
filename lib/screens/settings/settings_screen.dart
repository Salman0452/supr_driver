import 'package:flutter/material.dart';
import '../../Utils/theme_Constants.dart';
import '../../app/app_theme.dart';
import '../../app/routes.dart'; // Add this import
import 'package:get/get.dart'; // Add this import if not already there
import 'package:flutter/services.dart';
import 'profile_screen.dart'; // Add this import

class SettingsScreen extends StatefulWidget{
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    // Get current theme mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            // systemOverlayStyle: isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
            title: Text(
              "Settings",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // Everything else in an expanded, scrollable container
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User profile section
                      Row(
                        children: [
                          // Circular profile image
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
                            // You can replace this with actual user image
                          ),
                          const SizedBox(width: 16),
                          // User name and email
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  height: 30/20,
                                  color: isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'johndoe@gmail.com',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                  height: 18/12,
                                  color: isDarkMode ? Colors.grey[400] : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Account section
                      Text(
                        'Account',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          height: 24/16,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Account settings list tiles
                      _buildListTile(Icons.person_outline, 'Personal Account', isDarkMode: isDarkMode),
                      _buildListTile(Icons.directions_bus_rounded, 'Vehicle Information', isDarkMode: isDarkMode),
                      // _buildListTile(Icons.store_outlined, 'Store Details', isDarkMode: isDarkMode),
                      _buildListTile(Icons.location_on_outlined, 'Service area selection', isDarkMode: isDarkMode),
                      _buildListTile(Icons.access_time, 'Available Hours', isDarkMode: isDarkMode),
                      
                      const SizedBox(height: 30),
                      
                      // Preferences section
                      Text(
                        'Preferences',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          height: 24/16,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Preferences list tiles
                      _buildListTile(Icons.notifications_outlined, 'Notifications', isDarkMode: isDarkMode),
                      _buildListTile(Icons.notifications_outlined, 'Job type preferernces', isDarkMode: isDarkMode),
                      _buildListTile(Icons.payment, 'Payment Method', isDarkMode: isDarkMode),
                      
                      // Add theme toggle
                      _buildThemeToggle(isDarkMode),
                      
                      const SizedBox(height: 30),
                      
                      // Support section
                      Text(
                        'Support',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          height: 24/16,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Support list tiles
                      _buildListTile(Icons.help_outline, 'Help & Support', isDarkMode: isDarkMode),
                      _buildListTile(Icons.privacy_tip_outlined, 'Privacy Policy', isDarkMode: isDarkMode),
                      
                      const SizedBox(height: 40),
                      
                      // Log out button
                      Center(
                        child: TextButton.icon(
                          onPressed: () {
                            // Add logout functionality here
                            Get.offNamed(Routes.loginScreen);
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                          label: const Text(
                            'Log Out',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildThemeToggle(bool isDarkMode) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 0),
      child: ListTile(
        leading: Icon(
          isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: isDarkMode ? Colors.white : Colors.black,
          size: 22,
        ),
        title: Text(
          'Dark Mode',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 21/14,
            fontFamily: "Poppins",
            color: isDarkMode ? Colors.white : Color(0xFF1E1E1E),
          ),
        ),
        trailing: Switch(
          value: isDarkMode,
          onChanged: (value) {
            // Toggle between light and dark theme
            Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
          },
          activeColor: AppColors.PrimaryColor,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      ),
    );
  }
  
  Widget _buildListTile(IconData icon, String title, {required bool isDarkMode}) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 0),
      child: ListTile(
        splashColor: Colors.transparent,
        leading: Icon(
          icon,
          color: isDarkMode ? Colors.white : Color(0xFF000000),
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 21/14,
            fontFamily: "Poppins",
            color: isDarkMode ? Colors.white : Color(0xFF1E1E1E),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          size: 17,
          color: isDarkMode ? Colors.grey[400] : Color(0xFF545454),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        onTap: () {
          // Navigate based on the tile title
          if (title == 'Personal Account') {
            Get.toNamed(Routes.profileScreen); // Use Get navigation with the route
          } else if (title == 'Vehicle Information') {
            Get.toNamed(Routes.VehicleInfo);
          } else if (title == 'Privacy Policy') {
            Get.toNamed(Routes.privacyPolicyScreen); // Use Get navigation with the route
          } else if (title == 'Help & Support') {
            Get.toNamed(Routes.helpScreen); // Use Get navigation with the route
          } else if (title == 'Notifications') {
            Get.toNamed(Routes.notificationScreen); // Navigate to notification screen
          } else if (title == 'Payment Method') {
            Get.toNamed(Routes.paymentMethodScreen); // Navigate to payment method screen
          } else if (title == 'Available Hours') {
            Get.toNamed(Routes.workingHoursScreen); // Navigate to working hours screen
          } else if (title == 'Service area selection') {
            Get.toNamed(Routes.deliveryZone);
          } else if (title == 'Job type preferernces') {
            Get.toNamed(Routes.jobPref);
          }
          // Add other navigation options for different tiles here
        },
      ),
    );
  }
}