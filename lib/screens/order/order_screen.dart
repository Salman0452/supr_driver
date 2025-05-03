import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';
import 'package:supr_driver/app/app_theme.dart';
import 'package:supr_driver/screens/order/order_detail_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final ValueNotifier<String> selectFilter = ValueNotifier<String>('All');
  final List<String> filters = ["All","Pending","Ongoing","Completed","Cancelled"];
  
  // Example order data - in a real app this would come from your backend
  final List<Map<String, dynamic>> _orders = [
    {
      'id': 1,
      'status': 'Completed',
      'date': 'Oct 25, 2023 at 9:10pm',
      'customer_name': 'John Mbappe',
      'address': '123 Main Str.',
      'restaurant': 'Alex Michael',
      'time': '15 min',
      'distance': '5Km',
    },
    {
      'id': 2,
      'status': 'Pending',
      'date': 'Oct 26, 2023 at 10:20pm',
      'customer_name': 'Sarah Johnson',
      'address': '456 Oak Ave.',
      'restaurant': 'Pasta Palace',
      'time': '20 min',
      'distance': '3Km',
    },
    {
      'id': 3,
      'status': 'Ongoing',
      'date': 'Oct 27, 2023 at 11:30am',
      'customer_name': 'David Wilson',
      'address': '789 Pine Blvd.',
      'restaurant': 'Burger Joint',
      'time': '10 min',
      'distance': '2Km',
    },
    {
      'id': 4,
      'status': 'Cancelled',
      'date': 'Oct 28, 2023 at 12:40pm',
      'customer_name': 'Emily Brown',
      'address': '101 Maple Dr.',
      'restaurant': 'Sushi Bar',
      'time': '25 min',
      'distance': '7Km',
    },
    {
      'id': 5,
      'status': 'Completed',
      'date': 'Oct 29, 2023 at 1:50pm',
      'customer_name': 'Michael Smith',
      'address': '202 Elm St.',
      'restaurant': 'Pizza Place',
      'time': '30 min',
      'distance': '4Km',
    },
  ];

  // Filtered orders based on the selected filter
  List<Map<String, dynamic>> get filteredOrders {
    if (selectFilter.value == 'All') {
      return _orders;
    } else {
      return _orders.where((order) => order['status'] == selectFilter.value).toList();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // Get the current theme mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      // Use scaffold background color from theme instead of hardcoded white
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        // Use app bar background color from theme
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Colors.grey,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Orders",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              // Use text color from theme
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          SizedBox(
            height: 35,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 25),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if(selectFilter.value != filters[index]){
                      selectFilter.value = filters[index];
                      // Force rebuild to show filtered orders
                      setState(() {});
                    }
                  },
                  child: ValueListenableBuilder(
                    valueListenable: selectFilter,
                    builder: (context, value, child) =>
                      Container(
                        height: 35,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        decoration: value == filters[index] ? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.PrimaryColor
                        ) : BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            // Adjust border color for dark mode
                            color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                          )
                        ),
                        child: Text(
                          filters[index],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: value != filters[index] ? FontWeight.w400 : FontWeight.bold,
                            // Adjust text color for dark mode
                            color: value != filters[index] ? 
                              (isDarkMode ? Colors.grey[300] : AppColors.SecondaryColor) :
                              AppColors.SecondaryColor,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                  ),
                );
              }, 
              separatorBuilder: (context, index) => SizedBox(width: 15), 
              itemCount: filters.length
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: selectFilter,
              builder: (context, filterValue, child) {
                final orders = filteredOrders;
                return orders.isEmpty 
                  ? Center(
                      child: Text(
                        "No ${filterValue != 'All' ? filterValue : ''} orders found",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 25).copyWith(
                        bottom: 15
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 25), 
                      itemCount: orders.length,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        final orderStatus = order['status'];

                        return GestureDetector(
                          onTap: () => Get.to(() => OrderDetailScreen(orderData: order)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Order #${order['id']}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins',
                                          // Use text color from theme
                                          color: Theme.of(context).textTheme.titleMedium?.color,
                                        ),
                                      ),
                                      Text(
                                        order['date'],
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
                                        fixedSize: Size(74, 30),
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
                              SizedBox(height: 3),
                              Text(
                                order['customer_name'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                  // Use text color from theme
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                order['address'],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  // Use secondary text color for dark mode
                                  color: isDarkMode ? Colors.grey[400] : null,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                order['restaurant'],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  // Use secondary text color for dark mode
                                  color: isDarkMode ? Colors.grey[400] : null,
                                ),
                              ),
                              SizedBox(height: 3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    order['time'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      // Use secondary text color for dark mode
                                      color: isDarkMode ? Colors.grey[400] : null,
                                    ),
                                  ),
                                  Text(
                                    order['distance'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      // Use secondary text color for dark mode
                                      color: isDarkMode ? Colors.grey[400] : null,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 37,
                                    child: _buildActionButton(orderStatus, isDarkMode),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 50,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        );
                      },
                    );
              }
            ),
          )
        ],
      ),
    );
  }
  
  // New helper method to build the appropriate action button based on order status
  Widget _buildActionButton(String orderStatus, bool isDarkMode) {
    switch (orderStatus) {
      case 'Pending':
        return Row(
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: ThemeConstants.errorColor,
                padding: EdgeInsets.zero,
                side: const BorderSide(color: ThemeConstants.errorColor),
                fixedSize: Size(74, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'Reject',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(width: 10),
            OutlinedButton(
              onPressed: () {},
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
                'Accept',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ]
        );
        
      case 'Ongoing':
        return OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            backgroundColor: ThemeConstants.errorColor,
            padding: EdgeInsets.zero,
            side: const BorderSide(color: ThemeConstants.errorColor),
            fixedSize: Size(90, 37),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        );
        
      case 'Cancelled':
        return OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            side: BorderSide(color: isDarkMode ? Colors.grey[600]! : Colors.grey[400]!),
            backgroundColor: Colors.transparent,
            fixedSize: Size(90, 37),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text(
            'Cancelled',
            style: TextStyle(
              fontSize: 12,
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
            padding: EdgeInsets.zero,
            side: BorderSide(color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor),
            fixedSize: Size(90, 37),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text(
            'Delivered',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
            ),
          ),
        );
    }
  }
}
