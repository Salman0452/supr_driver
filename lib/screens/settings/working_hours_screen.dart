import 'package:flutter/material.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';
import 'package:supr_driver/app/app_theme.dart';

class WorkingHoursScreen extends StatefulWidget {
  const WorkingHoursScreen({Key? key}) : super(key: key);

  @override
  State<WorkingHoursScreen> createState() => _WorkingHoursScreenState();
}

class _WorkingHoursScreenState extends State<WorkingHoursScreen> {
  // Time slots from 7:00 AM to 7:00 PM (in 1-hour increments)
  final int _minHour = 7; // 7:00 AM
  final int _maxHour = 19; // 7:00 PM
  final int _totalSlots = 13; // (_maxHour - _minHour + 1) for 1 hour intervals
  
  // Map to store selected time ranges for each day
  final Map<String, Map<String, dynamic>> _workingHours = {
    'Monday': {'isOpen': true, 'startValue': 0.0, 'endValue': 12.0},
    'Tuesday': {'isOpen': true, 'startValue': 0.0, 'endValue': 12.0},
    'Wednesday': {'isOpen': true, 'startValue': 0.0, 'endValue': 12.0},
    'Thursday': {'isOpen': true, 'startValue': 0.0, 'endValue': 12.0},
    'Friday': {'isOpen': true, 'startValue': 0.0, 'endValue': 12.0},
    'Saturday': {'isOpen': false, 'startValue': 0.0, 'endValue': 12.0},
    'Sunday': {'isOpen': false, 'startValue': 0.0, 'endValue': 12.0},
  };

  // Convert slider value to time string
  String _valueToTime(double value) {
    int slotIndex = value.round();
    int hour = _minHour + slotIndex;
    
    String period = hour < 12 ? 'AM' : 'PM';
    int displayHour = hour > 12 ? hour - 12 : hour;
    if (hour == 12) displayHour = 12;
    if (hour == 0) displayHour = 12;
    
    return '$displayHour:00 $period';
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: isDarkMode ? Theme.of(context).appBarTheme.backgroundColor : ThemeConstants.scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_outlined,
              color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Working Hours',
            style: TextStyle(
              color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._workingHours.entries.map((entry) {
              String day = entry.key;
              bool isOpen = entry.value['isOpen'] as bool;
              // Add null safety checks for these values
              double startValue = (entry.value['startValue'] ?? 0.0) as double;
              double endValue = (entry.value['endValue'] ?? 12.0) as double;
              
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          day,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    if (isOpen && day != 'Saturday' && day != 'Sunday')
                      Column(
                        children: [
                          SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 6,
                              activeTrackColor: AppColors.PrimaryColor,
                              inactiveTrackColor: AppColors.PrimaryColor.withOpacity(0.4),
                              thumbColor: AppColors.PrimaryColor,
                              overlayColor: AppColors.PrimaryColor.withOpacity(0.2),
                              // Customize the tick marks to match the track color
                              tickMarkShape: RoundSliderTickMarkShape(
                                tickMarkRadius: 3.0,
                              ),
                              // Override the default color with a custom painter
                              activeTickMarkColor: AppColors.PrimaryColor,
                              inactiveTickMarkColor: AppColors.PrimaryColor.withOpacity(0.4),
                              showValueIndicator: ShowValueIndicator.always,
                            ),
                            child: RangeSlider(
                              values: RangeValues(startValue, endValue),
                              min: 0,
                              max: 12, // 7:00 AM to 7:00 PM (12 hours)
                              divisions: 12, // 1 hour increments
                              labels: RangeLabels(
                                _valueToTime(startValue),
                                _valueToTime(endValue),
                              ),
                              onChanged: (RangeValues values) {
                                setState(() {
                                  _workingHours[day]!['startValue'] = values.start;
                                  _workingHours[day]!['endValue'] = values.end;
                                });
                              },
                            ),
                          ),

                        ],
                      )
                    else if (day == 'Saturday' || day == 'Sunday')
                      Column(
                        children: [
                          // Show slider with disabled appearance
                          SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 6,
                              // Use lighter colors to indicate disabled state
                              activeTrackColor: AppColors.PrimaryColor,
                              inactiveTrackColor: AppColors.PrimaryColor,
                              thumbColor: AppColors.PrimaryColor,
                              overlayColor: Colors.transparent,
                              // Customize the tick marks with gray color
                              tickMarkShape: RoundSliderTickMarkShape(
                                tickMarkRadius: 3.0,
                              ),
                              activeTickMarkColor: AppColors.PrimaryColor,
                              inactiveTickMarkColor: isDarkMode ? Colors.grey[700] : Colors.grey.shade300,
                              showValueIndicator: ShowValueIndicator.never,
                            ),
                            child: RangeSlider(
                              values: RangeValues(0.0, 12.0), // Fixed values for weekend
                              min: 0,
                              max: 12,
                              divisions: 12,
                              onChanged: null, // Disabled slider
                            ),
                          ),
                          
                          // "Closed" indicator below the slider
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 8),
                              Text(
                                'Closed',
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white : Colors.black,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle save changes
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Working hours saved'),
                      backgroundColor: AppColors.PrimaryColor,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.PrimaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Save Changes',
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
    );
  }
}