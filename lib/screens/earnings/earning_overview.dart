import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';

import '../../app/app_theme.dart';
import 'earning_reports_screen.dart';

class EarningOverviewScreen extends StatefulWidget {
  const EarningOverviewScreen({Key? key}) : super(key: key);

  @override
  State<EarningOverviewScreen> createState() => _EarningOverviewScreenState();
}

class _EarningOverviewScreenState extends State<EarningOverviewScreen> {
  bool _showMonthSelector = false;
  String _selectedMonth = 'This month';
  
  final List<String> _monthOptions = [
    'This month',
    'March 2025',
    'February 2025',
  ];
  
  // Pie chart data
  final List<Map<String, dynamic>> _pieChartData = [
    {
      'name': 'Product A',
      'percent': 30,
      'color': const Color(0xFF800080), // Purple
    },
    {
      'name': 'Product B',
      'percent': 26,
      'color': const Color(0xFFFF92AE), // Pink
    },
    {
      'name': 'Product C',
      'percent': 24,
      'color': const Color(0xFFA6B7D4), // Light blue
    },
    {
      'name': 'Others',
      'percent': 20,
      'color': const Color(0xFF65DCAC), // Light green
    },
  ];
  
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
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_outlined,
              color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Earnings Overview',
            style: TextStyle(
              color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Month Selector Field
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showMonthSelector = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDarkMode ? Colors.grey[700]! : Colors.grey.shade300
                      ),
                      color: isDarkMode ? Color(0xFF303030) : Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedMonth,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: isDarkMode ? Colors.white : AppColors.SecondaryColor,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: isDarkMode ? Colors.white : AppColors.SecondaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Total Earnings Box
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Color(0xFF252525) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: isDarkMode ? [] : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title with upward arrow icon
                            Row(
                              children: [
                                Text(
                                  'Total Earnings',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_upward,
                                  size: 16,
                                  color: isDarkMode ? AppColors.PrimaryColor : Color(0xFF000000),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 10),
                            
                            // Amount
                            Text(
                              '₹43,780.00',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode ? AppColors.PrimaryColor : Color(0xFF000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Revenue Breakdown Section
                Text(
                  'Revenue Breakdown',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : AppColors.SecondaryColor,
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Pie Chart with Legend
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Color(0xFF252525) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: isDarkMode ? [] : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Pie Chart Section
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 180,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              PieChart(
                                PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 50,
                                  sections: _getPieChartSections(),
                                  borderData: FlBorderData(show: false),
                                ),
                              ),
                              // Total Amount in Center
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '₹43,780',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Spacer between chart and legend
                      const SizedBox(width: 50),

                      // Legend Section
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: _getPieLegendItems(isDarkMode),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                
                // View Reports Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.to(EarningReportsScreen());
                      // Handle view reports action
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: BorderSide(color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'View Reports',
                      style: TextStyle(
                        color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
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
          
          // Month Selector Overlay
          if (_showMonthSelector)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Color(0xFF303030) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with close button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Select Month',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: isDarkMode ? Colors.white70 : Colors.black.withOpacity(0.7),
                              ),
                              onPressed: () {
                                setState(() {
                                  _showMonthSelector = false;
                                });
                              },
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Month options (radio buttons)
                        ...List.generate(
                          _monthOptions.length,
                          (index) => RadioListTile(
                            title: Text(
                              _monthOptions[index],
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                              ),
                            ),
                            value: _monthOptions[index],
                            groupValue: _selectedMonth,
                            activeColor: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (value) {
                              setState(() {
                                _selectedMonth = value.toString();
                              });
                            },
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Apply Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _showMonthSelector = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.PrimaryColor,
                              foregroundColor: AppColors.PrimaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                color: Colors.black,
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
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  // Generate pie chart sections from data
  List<PieChartSectionData> _getPieChartSections() {
    return List.generate(

      _pieChartData.length,
      (index) {
        final item = _pieChartData[index];
        return PieChartSectionData(
          color: item['color'],
          value: item['percent'].toDouble(),
          title: '',
          radius: 25,
        );
      },
    );
  }
  
  // Generate legend items for the pie chart
  List<Widget> _getPieLegendItems(bool isDarkMode) {
    return List.generate(
      _pieChartData.length,
      (index) {
        final item = _pieChartData[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item['color'],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${item['percent']}%\n${item['name']}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}