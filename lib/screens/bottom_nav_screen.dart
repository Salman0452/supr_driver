import 'package:flutter/material.dart';
import 'package:supr_driver/screens/dashboard_screen.dart';
import 'package:supr_driver/screens/order/order_screen.dart';
import 'package:supr_driver/screens/settings/settings_screen.dart';
import 'package:supr_driver/screens/earnings/earning_screen.dart';
import '../../app/app_theme.dart';
import 'package:supr_driver/screens/maps/maps_screen.dart';



class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;
  
  // List of screens for each navigation item
  final List<Widget> _screens = [
    const DashboardScreen(),
    const OrdersScreen(),
    const MapsScreen(),
    const EarningScreen(),
    const SettingsScreen(),
  ];
  
  // Navigation item data
  final List<Map<String, dynamic>> _navItems = [
    {
      'icon': Icons.dashboard_outlined,
      'activeIcon': Icons.dashboard,
      'label': 'Dashboard',
    },
    {
      'icon': Icons.receipt_long_outlined,
      'activeIcon': Icons.receipt_long,
      'label': 'Orders',
    },
    {
      'icon': Icons.location_on_outlined,
      'activeIcon': Icons.location_on,
      'label': 'Maps',
    },
    {
      'icon': Icons.monetization_on_outlined,
      'activeIcon': Icons.monetization_on,
      'label': 'Earnings',
    },
    {
      'icon': Icons.settings_outlined,
      'activeIcon': Icons.settings,
      'label': 'Settings',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                _navItems.length,
                (index) => _buildNavItem(index),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildNavItem(int index) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        decoration: BoxDecoration(
          // color: isSelected ? ThemeConstants.primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? _navItems[index]['activeIcon'] : _navItems[index]['icon'],
              color: isSelected ? AppColors.PrimaryColor : (isDarkMode ?Color.fromRGBO(255, 255, 255, 1) : AppColors.SecondaryColor),
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              _navItems[index]['label'],
              style: TextStyle(
                fontSize: 12,
                height: 16/12,
                fontWeight: isSelected ? FontWeight.w400 : FontWeight.w400,
                color: isSelected ? (isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor) : (isDarkMode ? Color.fromRGBO(255, 255, 255, 0.7) : AppColors.SecondaryColor),
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}