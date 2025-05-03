import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/theme_Constants.dart';
import '../../app/app_theme.dart';

class EarningReportsScreen extends StatefulWidget {

  @override
  State<EarningReportsScreen> createState() => _EarningReportsScreenState();
}

class _EarningReportsScreenState extends State<EarningReportsScreen> {
  List<Color> gradientColors = [AppColors.PrimaryColor, Color(0xFFFFFFFF)];

  bool showAvg = false;
  bool _showMonthSelector = false;
  String _selectedMonth = 'Monthly';
  


  final List<String> _monthOptions = [
    'Daily',
    'Weekly',
    'Monthly'
  ];


  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.chevron_left_outlined, size: 30,
              color: isDarkMode ? Colors.white : Colors.black)),
        title: Text(
          "Earning Reports",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),


            GestureDetector(
              onTap: () {
                setState(() {
                  _showMonthSelector = true;
                  _showMonthDialog(context);
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

            SizedBox(height: 42,),


            Material(
              borderRadius: BorderRadius.circular(12.45),
              elevation: isDarkMode ? 0 : 0.2,
              color: isDarkMode ? Color(0xFF252525) : Colors.white,
              child: Container(
                height: 300,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(12.45)
                ),
                child: Column(
                  spacing: 25,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Revenue reports",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.45,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          height: 21,
                          child: OutlinedButton(
                            onPressed: () {

                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              side: BorderSide(
                                color: isDarkMode ? Colors.grey[700]! : Color(0xffDADADA)
                              ),
                              fixedSize: Size(50, 21),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Text(
                              'Export',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                    Expanded(
                      child: LineChart(


                          showAvg ? avgData() : mainData()),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            Text(
              "Report summary",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              ),
            ),
            SizedBox(height: 10),

            // Summary text items
            ...["Total Earning: 170.00", 
               "Average monthly earnings: 120.00", 
               "Lowest earnings: 120.00", 
               "Highest earnings: 120.00"].map((text) => 
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? Colors.white70 : ThemeConstants.textSecondary,
                  ),
                ),
              )
            ).toList(),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {

                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    side: BorderSide(color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,),
                    fixedSize: Size(74, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'PDF',
                    style: TextStyle(
                      color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {

                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    side: BorderSide(
                      color: isDarkMode ? Colors.grey[700]! : Color(0xffDADADA)
                    ),
                    fixedSize: Size(74, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Excel',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {

                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.PrimaryColor,
                    padding: EdgeInsets.zero,
                    side: BorderSide(color: AppColors.PrimaryColor),
                    fixedSize: Size(74, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Print',
                    style: TextStyle(
                      color:Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),



          ],
        ),
      ),
    );
  }
  void _showMonthDialog(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    showDialog(
      context: context,
      barrierDismissible: true, // Taps outside will dismiss the dialog
      barrierColor: Colors.black.withOpacity(0.5), // Background dim
      builder: (context) {
        return Dialog(
          backgroundColor: isDarkMode ? Color(0xFF303030) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with close button
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: isDarkMode ? Colors.white70 : Colors.black.withOpacity(0.7),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Text(
                      'Sort reports by',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                      ),
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
                          Navigator.of(context).pop();
                          // Do something with _selectedMonth if needed
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.PrimaryColor,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Save changes',
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
              );
            },
          ),
        );
      },
    );
  }
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.w600, fontSize: 7.78);
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text(
            'Jan', style: style);
        break;
      case 3:
        text = const Text('Feb', style: style);
        break;
      case 5:
        text = const Text('Mar', style: style);
        break;
      case 7:
        text = const Text('Apr', style: style);
        break;
      case 9:
        text = const Text('Jun', style: style);
        break;
      case 11:
        text = const Text('Jul', style: style);
        break;
      case 13:
        text = const Text('Aug', style: style);
        break;
      case 15:
        text = const Text('Sep', style: style);
        break;
      case 17:
        text = const Text('Oct', style: style);
        break;
      case 19:
        text = const Text('Nov', style: style);
        break;
      case 21:
        text = const Text('Dec', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(  meta: meta,
        child: text);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.w600, fontSize: 7.78);
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1K';
        break;
      case 3:
        text = '2k';
        break;
      case 5:
        text = '3k';
        break;
      case 7:
        text = '5K';
        break;

      case 9:
        text = '10K';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: false,
        drawHorizontalLine: false,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(color: Color(0xff37434d), strokeWidth: 1);
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(color: Color(0xff37434d), strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            maxIncluded: true,

            showTitles: true,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 25,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(
                begin: gradientColors[0],
                end: gradientColors[1],
              ).lerp(0.2)!,
              ColorTween(
                begin: gradientColors[0],
                end: gradientColors[1],
              ).lerp(0.2)!,
            ],
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(
                  begin: gradientColors[0],
                  end: gradientColors[1],
                ).lerp(0.2)!.withValues(alpha: 0.1),
                ColorTween(
                  begin: gradientColors[0],
                  end: gradientColors[1],
                ).lerp(0.2)!.withValues(alpha: 0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,

        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(color: Colors.white10, strokeWidth: 1);
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(color: Colors.white10, strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        show: true,

        rightTitles: const AxisTitles(

          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval:1,
            reservedSize: 35,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 35,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 9,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          color: AppColors.PrimaryColor,
          barWidth: 2,
          isStrokeCapRound: false,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:
              gradientColors
                  .map((color) => color.withValues(alpha: 0.5))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

}
