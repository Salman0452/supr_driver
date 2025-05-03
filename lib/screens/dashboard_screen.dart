import 'package:flutter/material.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';
import 'package:supr_driver/screens/chat/chat_list_screen.dart';
import '../../app/app_theme.dart';
import 'package:get/get.dart';
import 'package:supr_driver/app/routes.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Sample weekly earnings data for the bar chart
  final List<double> weeklyEarnings = [30, 45, 60, 25, 75, 50, 40];
  final List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dashboard title outside of colored container
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 20.0, right: 25.0),
              child: Text(
                'Dashboard',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                ),
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Everything else with the light green background - now in an expanded, scrollable container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.PrimaryColor.withOpacity(0.3),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Greeting and profile image in a row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Greeting text with avatar next to "Hello"
                            Row(
                              children: [
                                // Profile Image now moved next to Hello text
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[200],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      'https://randomuser.me/api/portraits/men/32.jpg',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.person,
                                          size: 30,
                                          color: Colors.grey,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(width: 10),
                                
                                // Greeting text moved right after avatar
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hello,',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "John De",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            // Chat icon with notification dot
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ChatListScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isDarkMode ? AppColors.SecondaryColor.withOpacity(0.5) : AppColors.lightSecondaryColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 5,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.chat_outlined,
                                      size: 24,
                                      color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                                    ),
                                  ),
                                ),
                                // Red notification dot
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Two metric boxes in a row
                        Column(
                          children: [
                            Row(
                              children: [
                                // Total Sale Box
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          AppColors.PrimaryColor, // Green start color
                                          AppColors.PrimaryColor, // Green end color
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.PrimaryColor.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Earning',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.SecondaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '₹. 1200.70',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.SecondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 15),

                                // Total Order Box
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          AppColors.PrimaryColor, // Green start color
                                          AppColors.PrimaryColor, // Green end color
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.PrimaryColor.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Deliveries',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.SecondaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '70',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.SecondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                // Total Sale Box
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          AppColors.PrimaryColor, // Green start color
                                          AppColors.PrimaryColor, // Green end color
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.PrimaryColor.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Rating',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.SecondaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text(
                                              '4.8',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.SecondaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 15),

                                // Total Order Box
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          AppColors.PrimaryColor, // Green start color
                                          AppColors.PrimaryColor, // Green end color
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.PrimaryColor.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hours',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.SecondaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '50',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.SecondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            // Add Earnings label and chart
                            const SizedBox(height: 30),
                            Text(
                              'Earnings',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              height: 220,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: AppColors.PrimaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.PrimaryColor.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Weekly Earnings (₹)',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.SecondaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Expanded(
                                    child: BarChart(
                                      BarChartData(
                                        alignment: BarChartAlignment.spaceAround,
                                        maxY: 100,
                                        minY: 0,
                                        barTouchData: BarTouchData(
                                          enabled: true,
                                          touchTooltipData: BarTouchTooltipData(
                                            tooltipPadding: const EdgeInsets.all(8),
                                            tooltipMargin: 8,
                                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                              return BarTooltipItem(
                                                '₹${weeklyEarnings[groupIndex] * 10}',
                                                TextStyle(
                                                  color: AppColors.PrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        titlesData: FlTitlesData(
                                          show: true,
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (value, meta) {
                                                if (value < 0 || value >= weekDays.length) {
                                                  return const Text('');
                                                }
                                                return Text(
                                                  weekDays[value.toInt()],
                                                  style: TextStyle(
                                                    color: AppColors.SecondaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          leftTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              interval: 10,
                                              getTitlesWidget: (value, meta) {
                                                if (value % 20 != 0) return const Text('');
                                                return Text(
                                                  '${value.toInt()}',
                                                  style: TextStyle(
                                                    color: AppColors.SecondaryColor,
                                                    fontSize: 10,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                        ),
                                        gridData: FlGridData(
                                          show: true,
                                          drawVerticalLine: false,
                                          getDrawingHorizontalLine: (value) {
                                            return FlLine(
                                              color: AppColors.SecondaryColor.withOpacity(0.2),
                                              strokeWidth: 1,
                                            );
                                          },
                                        ),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        barGroups: List.generate(
                                          weeklyEarnings.length,
                                          (index) => BarChartGroupData(
                                            x: index,
                                            barRods: [
                                              BarChartRodData(
                                                toY: weeklyEarnings[index],
                                                color: AppColors.SecondaryColor,
                                                width: 20,
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(6),
                                                  topRight: Radius.circular(6),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 25),
                        
                        // New Order Alert heading with notification icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'New Order Alert',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                              ),
                            ),
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDarkMode ? AppColors.SecondaryColor.withOpacity(0.2) : AppColors.PrimaryColor,
                              ),
                              child: Icon(
                                Icons.notifications_none_outlined,
                                color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                                size: 21,
                              ),
                            ),
                          ],
                        ),
                        
                        // New Order card
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black45 : AppColors.lightSecondaryColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                // Restaurant name and price
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Burger Palace',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                                      ),
                                    ),
                                    Text(
                                      '₹350',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                const SizedBox(height: 12),
                                
                                // Address with location icon
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 20,
                                      color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        '123 Main Street, Sector 12, New Delhi',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                const SizedBox(height: 12),
                                
                                // Time
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 20,
                                      color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Today, 4:30 PM',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                                
                                const SizedBox(height: 20),
                                
                                // Reject and Accept buttons
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ThemeConstants.errorColor,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text(
                                          'Reject',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.PrimaryColor,
                                          foregroundColor: AppColors.SecondaryColor,
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text(
                                          'Accept',
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
                              ],
                            ),
                          ),
                        ),
                        
                        // Add some bottom padding
                        const SizedBox(height: 20),
                        
                        // Insights heading
                        Text(
                          'Insights',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                          ),
                        ),
                        
                        // Insights containers
                        const SizedBox(height: 15),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black45 : AppColors.lightSecondaryColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Circular icon container
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isDarkMode ? AppColors.PrimaryColor.withOpacity(0.2) : AppColors.SecondaryColor.withOpacity(0.5),
                                ),
                                child: Icon(
                                  Icons.trending_up,
                                  color: AppColors.PrimaryColor,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 15),
                              // Text content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Peak Hours',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                                      ),
                                    ),
                                    Text(
                                      'Earnings are 45% higher between 6 - 8 PM',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black45 : AppColors.lightSecondaryColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Circular icon container
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isDarkMode ? AppColors.PrimaryColor.withOpacity(0.2) : AppColors.SecondaryColor.withOpacity(0.5),
                                ),
                                child: Icon(
                                  Icons.trending_up,
                                  color: AppColors.PrimaryColor,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 15),
                              // Text content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Opportunity',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                                      ),
                                    ),
                                    Text(
                                      'Downtown area has high demand this weekend',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black45 : AppColors.lightSecondaryColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Circular icon container
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ThemeConstants.errorColor.withOpacity(0.2),
                                ),
                                child: Icon(
                                  Icons.trending_down,
                                  color: ThemeConstants.errorColor,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 15),
                              // Text content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Low Activity',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                                      ),
                                    ),
                                    Text(
                                      'Monday morning shows 20% less activity',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Add some bottom padding
                        const SizedBox(height: 15),
                        
                        // Recent Deliveries heading
                        Text(
                          'Recent Deliveries',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                          ),
                        ),
                        
                        // Recent delivery items
                        const SizedBox(height: 15),
                        
                        // Delivery Item 1
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black45 : AppColors.lightSecondaryColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Restaurant name and price
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Burger Palace',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                                    ),
                                  ),
                                  Text(
                                    '₹380',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Address with location icon
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 20,
                                    color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      '123 Main Street, Sector 12, New Delhi',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Time
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 20,
                                    color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Today, 2:30 PM',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Delivery Item 2
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black45 : AppColors.lightSecondaryColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Restaurant name and price
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pizza Express',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                                    ),
                                  ),
                                  Text(
                                    '₹450',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Address with location icon
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 20,
                                    color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      '45 Market Street, Cyber City, Gurugram',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Time
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 20,
                                    color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Today, 12:15 PM',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Delivery Item 3
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black45 : AppColors.lightSecondaryColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Restaurant name and price
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tandoori Nights',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                                    ),
                                  ),
                                  Text(
                                    '₹520',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Address with location icon
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 20,
                                    color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      '78 Dining Square, South Extension, New Delhi',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Time
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 20,
                                    color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Yesterday, 7:45 PM',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Delivery Item 4
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black45 : AppColors.lightSecondaryColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Restaurant name and price
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Noodle House',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                                    ),
                                  ),
                                  Text(
                                    '₹310',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Address with location icon
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 20,
                                    color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      '15 Asian Alley, DLF Phase 3, Gurugram',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Time
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 20,
                                    color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Yesterday, 1:20 PM',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Add some bottom padding
                        const SizedBox(height: 15),
                        
                        // Upcoming Schedule heading with See All
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Upcoming Schedule',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to see all schedules
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 15),
                        
                        // Schedule container
                        Container(
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black45 : AppColors.lightSecondaryColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // This Week with calendar icon
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 18,
                                      color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'This Week',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                const SizedBox(height: 15),
                                
                                // Days of week (M-S)
                                SizedBox(
                                  height: 40,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      _buildDayItem('M', true, isDarkMode),
                                      _buildDayItem('T', false, isDarkMode),
                                      _buildDayItem('W', false, isDarkMode),
                                      _buildDayItem('T', false, isDarkMode),
                                      _buildDayItem('F', false, isDarkMode),
                                      _buildDayItem('S', false, isDarkMode),
                                      _buildDayItem('S', false, isDarkMode),
                                    ],
                                  ),
                                ),
                                
                                const SizedBox(height: 15),
                                
                                // Schedule items
                                _buildScheduleItem('Monday', '5:00 PM - 10:00 PM', isDarkMode),
                                const SizedBox(height: 10),
                                _buildScheduleItem('Wednesday', '6:00 PM - 11:00 PM', isDarkMode),
                                const SizedBox(height: 10),
                                _buildScheduleItem('Friday', '4:30 PM - 9:30 PM', isDarkMode),
                                const SizedBox(height: 10),
                                _buildScheduleItem('Saturday', '12:00 PM - 5:00 PM', isDarkMode),
                              ],
                            ),
                          ),
                        ),
                        
                        // Add some bottom padding
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayItem(String day, bool isSelected, bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.PrimaryColor : (isDarkMode ? Colors.black45 : AppColors.lightSecondaryColor),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.SecondaryColor : (isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleItem(String day, String time, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black45 : AppColors.lightSecondaryColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isDarkMode ? AppColors.lightSecondaryColor.withOpacity(0.7) : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}