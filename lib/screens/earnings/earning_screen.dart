import 'package:flutter/material.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';
import 'package:supr_driver/app/routes.dart';
import '../../app/app_theme.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  bool _showFilterOverlay = false;
  String _selectedFilter = 'Weekly';
  final List<String> _filterOptions = ['Daily', 'Weekly', 'Monthly'];

  // Example transaction data
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': '10',
      'amount': '₹780',
      'date': '15 Apr, 2025',
      'time': '10:30 AM',
      'status': 'Completed',
      'statusColor': AppColors.PrimaryColor, // Green for completed
    },
    {
      'id': '09',
      'amount': '₹540',
      'date': '14 Apr, 2025',
      'time': '02:15 PM',
      'status': 'Pending',
      'statusColor': Color(0xFFFFBC4F), // Yellow for pending
    },
    {
      'id': '08',
      'amount': '₹320',
      'date': '13 Apr, 2025',
      'time': '09:45 AM',
      'status': 'Completed',
      'statusColor': AppColors.PrimaryColor,
    },
    {
      'id': '07',
      'amount': '₹650',
      'date': '12 Apr, 2025',
      'time': '04:20 PM',
      'status': 'Cancelled',
      'statusColor': Color(0xFFDC0D27), // Red for cancelled
    },
    {
      'id': '06',
      'amount': '₹480',
      'date': '11 Apr, 2025',
      'time': '11:05 AM',
      'status': 'Completed',
      'statusColor': AppColors.PrimaryColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Main content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Page title
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 20.0, right: 25.0),
                  child: Text(
                    'Your supr earnings',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ATM-like card with gradient background
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.PrimaryColor,  // Green start color
                                AppColors.PrimaryColor,  // Green start color
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Available Balance text
                              const Text(
                                'Available Balance',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF000000),
                                ),
                              ),

                              const SizedBox(height: 15),

                              // Amount (centered)
                              Text(
                                '₹20,450',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.start,
                              ),

                              const SizedBox(height: 15),

                              // Withdraw to Bank button
                              GestureDetector(
                                onTap: () {
                                  // Navigate to withdraw balance screen
                                  Routes.withdrawBalanceScreen.push();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Withdraw to Bank',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF0000000),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.chevron_right,
                                      color: Color(0xFF000000),
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Earnings breakdown (Two containers in a row)
                        Row(
                          children: [
                            // Total Earnings Box
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to earnings overview screen
                                  Routes.earningOverviewScreen.push();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
                                  decoration: BoxDecoration(
                                    color: isDarkMode ? Color(0xFF252525) : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: isDarkMode ? [] : [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Total Earnings with arrow up icon
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total Earnings',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: isDarkMode ? Colors.white : Colors.black,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_upward,
                                            size: 16,
                                            color: isDarkMode ? AppColors.PrimaryColor : Colors.black,
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 10),

                                      // Amount with arrow
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '₹780.00',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: isDarkMode ? AppColors.PrimaryColor : Colors.black,
                                            ),
                                          ),
                                          Icon(
                                            Icons.chevron_right_outlined,
                                            size: 18,
                                            color: isDarkMode ? AppColors.PrimaryColor : Colors.black,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 16),

                            // Total Payouts Box
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                                decoration: BoxDecoration(
                                  color: isDarkMode ? Color(0xFF252525) : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: isDarkMode ? [] : [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Total Payouts with ATM icon
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Payouts',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: isDarkMode ? AppColors.lightSecondaryColor : Colors.black,
                                          ),
                                        ),
                                        // SizedBox(width: 5),
                                        Icon(
                                          Icons.credit_card,
                                          size: 16,
                                          color: isDarkMode ? AppColors.PrimaryColor : Colors.black,
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 10),

                                    // Amount
                                    Text(
                                      '₹780.00',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode ? AppColors.PrimaryColor : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Transaction History header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transaction History',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                              ),
                            ),
                            // Filter icon
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showFilterOverlay = true;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.PrimaryColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Icon(
                                  Icons.tune,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Transaction List
                        ...List.generate(
                          _transactions.length,
                          (index) => _buildTransactionItem(_transactions[index], isDarkMode),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Filter Overlay (conditionally shown) - moved outside of column to be on top
          if (_showFilterOverlay)
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
                              'Sort Transaction History',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: isDarkMode ? Colors.white : Color(0xFF000000).withOpacity(0.7),),
                              onPressed: () {
                                setState(() {
                                  _showFilterOverlay = false;
                                });
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Filter options (radio buttons)
                        ...List.generate(
                          _filterOptions.length,
                          (index) => RadioListTile(
                            title: Text(
                              _filterOptions[index],
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                              ),
                            ),
                            value: _filterOptions[index],
                            groupValue: _selectedFilter,
                            activeColor: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (value) {
                              setState(() {
                                _selectedFilter = value.toString();
                              });
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Save Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle saving filter
                              setState(() {
                                _showFilterOverlay = false;
                                // Apply filter logic here
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.PrimaryColor,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
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
            ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction, bool isDarkMode) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF252525) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: isDarkMode ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.PrimaryColor.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: Transform.rotate(
            angle: 65,
            child: Icon(
              Icons.payments_outlined,
              color: isDarkMode ? transaction['statusColor'] : AppColors.SecondaryColor,
              size: 20,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Payment for order #${transaction['id']}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              ),
            ),
            Text(
              transaction['amount'],
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? transaction['statusColor'] : AppColors.SecondaryColor,
              ),
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${transaction['date']} at ${transaction['time']}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: isDarkMode ? Colors.grey[400] : Color(0xFF000000).withOpacity(0.7),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: isDarkMode ? transaction['statusColor'].withOpacity(0.08) : AppColors.SecondaryColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                transaction['status'],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 8,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? transaction['statusColor'] : transaction['statusColor'],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}