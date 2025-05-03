import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';
import 'package:supr_driver/app/app_theme.dart';

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? orderData;
  
  const OrderDetailScreen({super.key, this.orderData});

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // Use orderData or fallback to default values
    final orderId = orderData?['id'] ?? 1;
    final orderDate = orderData?['date'] ?? 'Oct 25, 2023 at 9:10pm';
    final orderStatus = orderData?['status'] ?? 'Completed';
    final customerName = orderData?['customer_name'] ?? 'John Mbappe';
    final deliveryAddress = orderData?['address'] ?? '345 Clement Str';
    final restaurant = orderData?['restaurant'] ?? 'Burger Palace';
    final time = orderData?['time'] ?? '15 min';
    final distance = orderData?['distance'] ?? '5Km';
    
    return Scaffold(
      // Use scaffold background color from theme
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        // Use app bar background color from theme
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          // Use icon color from theme
          child: Icon(Icons.chevron_left_outlined,
            color: Theme.of(context).iconTheme.color, size: 30,),
        ),
        title: Text(
          "Order Details",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            // Use text color from theme
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order ID, Date and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #$orderId",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          // Use text color from theme
                          color: Theme.of(context).textTheme.titleMedium?.color,
                        ),
                      ),
                      Text(
                        orderDate,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          // Use secondary text color for dark mode
                          color: isDarkMode ? Colors.grey[400] : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        side: BorderSide.none,
                        fixedSize: Size(90, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        orderStatus,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color:
                            orderStatus == 'Pending' ? Color(0xffFFBC4F) :
                            orderStatus == 'Ongoing' ? Color(0xff554FFF) :
                            orderStatus == 'Cancelled' ? ThemeConstants.errorColor :
                            isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              
              // Restaurant Name
              Text(
                restaurant,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  // Use text color from theme
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: 20),
              
              // Use appropriate divider color for dark mode
              Divider(color: isDarkMode ? Colors.grey[800] : Color(0xffCECECE)),
              SizedBox(height: 15),
              
              // Items section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: 3),
                    margin: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.fastfood_outlined,
                      size: 20,
                      color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Items:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                        ),
                      ),
                      // Small gap between title and items
                      SizedBox(height: 5),
                      Text(
                        "2x Classic Burgers",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          // Use appropriate text color for dark mode
                          color: isDarkMode ? Colors.grey[400] : ThemeConstants.textSecondary,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "1x Large Fries",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          // Use appropriate text color for dark mode
                          color: isDarkMode ? Colors.grey[400] : ThemeConstants.textSecondary,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "1x Chocolate Shake",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          // Use appropriate text color for dark mode
                          color: isDarkMode ? Colors.grey[400] : ThemeConstants.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              
              // Pickup from section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: 3),
                    margin: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.store_outlined,
                      size: 20,
                      color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Pickup from:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                        ),
                      ),
                      // Small gap between title and address
                      SizedBox(height: 5),
                      Text(
                        "123 Main Str.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          // Use appropriate text color for dark mode
                          color: isDarkMode ? Colors.grey[400] : ThemeConstants.textSecondary,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              
              // Deliver to section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: 3),
                    margin: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 20,
                      color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Deliver to:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                        ),
                      ),
                      // Small gap between title and address
                      SizedBox(height: 5),
                      Text(
                        deliveryAddress,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          // Use appropriate text color for dark mode
                          color: isDarkMode ? Colors.grey[400] : ThemeConstants.textSecondary,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              
              // Customer section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: 3),
                    margin: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.person_outline,
                      size: 20,
                      color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Customer:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                        ),
                      ),
                      // Small gap between title and customer name
                      SizedBox(height: 5),
                      Text(
                        customerName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          // Use appropriate text color for dark mode
                          color: isDarkMode ? Colors.grey[400] : ThemeConstants.textSecondary,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "+91 69402854", // Example phone number
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          // Use appropriate text color for dark mode
                          color: isDarkMode ? Colors.grey[400] : ThemeConstants.textSecondary,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25),
              
              // Divider before the info boxes
              Divider(color: isDarkMode ? Colors.grey[800] : Color(0xffCECECE)),
              SizedBox(height: 20),
              
              // Three containers in a row: Distance, Est. Time, Payment
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Distance
                  _buildInfoBox(
                    context, 
                    "Distance", 
                    distance, 
                    Icons.directions_car_outlined,
                    isDarkMode
                  ),
                  
                  // Est. Time
                  _buildInfoBox(
                    context, 
                    "Est. Time", 
                    time, 
                    Icons.access_time,
                    isDarkMode
                  ),
                  
                  // Payment
                  _buildInfoBox(
                    context, 
                    "Payment", 
                    "रु 350", 
                    Icons.payment_outlined,
                    isDarkMode
                  ),
                ],
              ),
              
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      
      // Bottom action buttons based on order status
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: _buildActionButtons(orderStatus, isDarkMode),
      ),
    );
  }
  
  // Helper method to build consistent info boxes
  Widget _buildInfoBox(BuildContext context, String title, String value, IconData iconData, bool isDarkMode) {
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            iconData,
            size: 20,
            color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to build action buttons based on order status
  Widget _buildActionButtons(String orderStatus, bool isDarkMode) {
    switch (orderStatus) {
      case 'Pending':
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: ThemeConstants.errorColor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  side: const BorderSide(color: ThemeConstants.errorColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Reject',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.PrimaryColor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Accept',
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
        );
        
      case 'Ongoing':
        return ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.PrimaryColor,
            foregroundColor: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Complete Delivery',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
        
      case 'Cancelled':
        return OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            side: BorderSide(color: isDarkMode ? Colors.grey[600]! : Colors.grey[400]!),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Order was Cancelled',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        );
        
      case 'Completed':
      default:
        return OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            side: BorderSide(color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Order Delivered',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
            ),
          ),
        );
    }
  }
}
