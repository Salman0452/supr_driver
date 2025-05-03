import 'package:flutter/material.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';
import 'package:supr_driver/app/app_theme.dart';

class DeliveryZoneScreen extends StatefulWidget {
  const DeliveryZoneScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryZoneScreen> createState() => _DeliveryZoneScreenState();
}

class _DeliveryZoneScreenState extends State<DeliveryZoneScreen> {
  final TextEditingController _customFeeController = TextEditingController();
  bool _showCustomFeeOverlay = false;
  bool _showZoneSelectionOverlay = false;
  String _selectedZone = 'South Delhi Zone';
  final List<Map<String, dynamic>> _deliveryFees = [
    {'distance': '2Km', 'isSelected': true},
    {'distance': '5Km', 'isSelected': false},
    {'distance': '10Km', 'isSelected': false},
    {'distance': '25Km', 'isSelected': false},
  ];

  // List of India zones
  final List<String> _indiaZones = [
    'South Delhi Zone',
    'North Delhi Zone',
    'East Delhi Zone',
    'West Delhi Zone',
    'Central Delhi Zone',
    'Mumbai South Zone',
    'Mumbai North Zone',
    'Bengaluru Central Zone',
    'Bengaluru East Zone',
    'Chennai Central Zone',
    'Kolkata North Zone',
    'Hyderabad Metro Zone',
    'Pune City Zone'
  ];

  @override
  void dispose() {
    _customFeeController.dispose();
    super.dispose();
  }

  void _selectFee(int index) {
    setState(() {
      for (int i = 0; i < _deliveryFees.length; i++) {
        _deliveryFees[i]['isSelected'] = (i == index);
      }
    });
  }

  void _selectZone(String zone) {
    setState(() {
      _selectedZone = zone;
      _showZoneSelectionOverlay = false;
    });
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
            'Service area',
            style: TextStyle(
              color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            padding: EdgeInsets.zero, // Remove overall padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Map image with full width (no horizontal padding)
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    // Remove border radius for full width appearance
                    image: const DecorationImage(
                      image: NetworkImage('https://developers.google.com/static/codelabs/maps-platform/full-stack-store-locator/img/58a6680e9c8e7396.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  //Optional overlay for better text visibility
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _selectedZone,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                
                // Add padding for the content below the image
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Select Zone (Moved to the top)
                      Text(
                        'Select Zone',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Zone selector field (replaces dropdown)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showZoneSelectionOverlay = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
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
                                _selectedZone,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: isDarkMode ? Colors.white70 : Colors.grey[700],
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Delivery Fee with custom fee option (Moved below zone selection)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Maximum Distance',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _showCustomFeeOverlay = true;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Add custom distance',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                    color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.add_circle_outline,
                                  size: 18,
                                  color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Delivery fee options in a horizontal scroll view
                      Container(
                        height: 60,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              _deliveryFees.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () => _selectFee(index),
                                  child: Container(
                                    width: 70,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: _deliveryFees[index]['isSelected']
                                          ? AppColors.PrimaryColor
                                          : isDarkMode ? Color(0xFF303030) : Colors.white,
                                      border: Border.all(
                                        color: _deliveryFees[index]['isSelected']
                                            ? AppColors.PrimaryColor
                                            : Colors.grey.shade300,
                                        width: 1,
                                      ),
                                      boxShadow: isDarkMode ? [] : [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        _deliveryFees[index]['distance'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                          color: _deliveryFees[index]['isSelected']
                                              ? Colors.black
                                              : isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Save button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle save changes
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Settings saved'),
                                backgroundColor: AppColors.PrimaryColor,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.PrimaryColor,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Save zone',
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
              ],
            ),
          ),
        
          // Custom Fee Overlay (conditionally shown)
          if (_showCustomFeeOverlay)
            Container(
              color: Colors.black.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Color(0xFF303030) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
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
                            'Add Custom Delivery Fee',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: isDarkMode ? Colors.white : Colors.black),
                            onPressed: () {
                              setState(() {
                                _showCustomFeeOverlay = false;
                              });
                            },
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Delivery Fee Label
                      Text(
                        'Delivery fee',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Fee Input Field
                      TextField(
                        controller: _customFeeController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter amount',
                          hintStyle: TextStyle(
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          ),
                          prefixText: 'Km ',
                          prefixStyle: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          filled: true,
                          fillColor: isDarkMode ? Color(0xFF404040) : Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: isDarkMode ? Colors.grey[700]! : Colors.grey.shade300
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: isDarkMode ? Colors.grey[700]! : Colors.grey.shade300
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.PrimaryColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle saving custom fee
                            if (_customFeeController.text.isNotEmpty) {
                              // Add custom fee to the options or replace an existing one
                              setState(() {
                                _deliveryFees.add({
                                  'distance': '${_customFeeController.text}km',
                                  'isSelected': true,
                                });
                                
                                // Update selection
                                for (int i = 0; i < _deliveryFees.length - 1; i++) {
                                  _deliveryFees[i]['isSelected'] = false;
                                }
                                
                                _showCustomFeeOverlay = false;
                                _customFeeController.clear(); // Clear input after adding
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDarkMode ? AppColors.PrimaryColor : AppColors.PrimaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
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
              ),
            ),
            
          // Zone Selection Overlay
          if (_showZoneSelectionOverlay)
            Container(
              color: Colors.black.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Color(0xFF303030) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
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
                            'Select Zone',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: isDarkMode ? Colors.white : Colors.black),
                            onPressed: () {
                              setState(() {
                                _showZoneSelectionOverlay = false;
                              });
                            },
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Zone search field
                      TextField(
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search zones',
                          hintStyle: TextStyle(
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          ),
                          filled: true,
                          fillColor: isDarkMode ? Color(0xFF404040) : Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: isDarkMode ? Colors.grey[700]! : Colors.grey.shade300
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: isDarkMode ? Colors.grey[700]! : Colors.grey.shade300
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.PrimaryColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Zone list
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: _indiaZones.length,
                          separatorBuilder: (context, index) => Divider(
                            color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                            height: 1,
                          ),
                          itemBuilder: (context, index) {
                            final zone = _indiaZones[index];
                            final isSelected = zone == _selectedZone;
                            
                            return ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              title: Text(
                                zone,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                  fontSize: 14,
                                  color: isSelected 
                                      ? AppColors.PrimaryColor
                                      : isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              trailing: isSelected 
                                ? Icon(Icons.check_circle, color: AppColors.PrimaryColor)
                                : null,
                              onTap: () => _selectZone(zone),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
