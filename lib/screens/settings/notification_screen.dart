import 'package:flutter/material.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';
import 'package:supr_driver/app/app_theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
            'Notifications',
            style: TextStyle(
              color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: isDarkMode ? Color(0xFF303030) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: isDarkMode ? [] : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 2),
                  blurRadius: 5,
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.PrimaryColor,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.PrimaryColor,
              unselectedLabelColor: isDarkMode ? Colors.white : Color(0xFF000000),
              labelStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Unread'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // All notifications tab
                _buildNotificationList(allNotifications, isDarkMode),
                // Unread notifications tab
                _buildNotificationList(
                  allNotifications.where((notification) => !notification.isRead).toList(),
                  isDarkMode
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(List<Notification> notifications, bool isDarkMode) {
    return notifications.isEmpty
        ? Center(
            child: Text(
              'No notifications',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: isDarkMode ? Colors.grey[400] : Colors.grey,
              ),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return _buildNotificationItem(notification, isDarkMode);
            },
          );
  }

  Widget _buildNotificationItem(Notification notification, bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF252525) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: isDarkMode ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        splashColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: notification.iconBackgroundColor.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            notification.icon,
            color: notification.iconBackgroundColor,
            size: 22,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                notification.title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: notification.isRead ? FontWeight.w500 : FontWeight.w600,
                  color: isDarkMode ? Colors.white : ThemeConstants.textSecondary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (!notification.isRead)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.PrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  notification.unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 5),
            Expanded(
              child: Text(
                notification.subtitle,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: isDarkMode ? Colors.grey[400] : Colors.black.withOpacity(0.7),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              notification.time,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: isDarkMode ? Colors.grey[500] : Color(0xFF8A8A8E),
              ),
            ),
          ],
        ),
        isThreeLine: true,
        trailing: null, // Remove trailing since we've moved the time to subtitle
        onTap: () {
          setState(() {
            final index = allNotifications.indexOf(notification);
            if (index != -1) {
              allNotifications[index] = notification.copyWith(isRead: true);
            }
          });
        },
      ),
    );
  }
}

class Notification {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final bool isRead;
  final int unreadCount;
  final IconData icon;
  final Color iconBackgroundColor;

  const Notification({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isRead,
    required this.unreadCount,
    required this.icon,
    required this.iconBackgroundColor,
  });

  Notification copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? time,
    bool? isRead,
    int? unreadCount,
    IconData? icon,
    Color? iconBackgroundColor,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
      unreadCount: unreadCount ?? this.unreadCount,
      icon: icon ?? this.icon,
      iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
    );
  }
}

// Sample notification data
List<Notification> allNotifications = [
  Notification(
    id: '1',
    title: 'New Order Received',
    subtitle: 'Order for #23-456-789 has been received.',
    time: '10 mins ago',
    isRead: false,
    unreadCount: 1,
    icon: Icons.shopping_bag_outlined,
    iconBackgroundColor: Colors.red,
  ),
  Notification(
    id: '2',
    title: 'Low Stock Alert',
    subtitle: 'Headphones (SKU: HP-002) is running low on stock.',
    time: '1 hour ago',
    isRead: false,
    unreadCount: 2,
    icon: Icons.inventory_2_outlined,
    iconBackgroundColor: Colors.orange,
  ),
  Notification(
    id: '3',
    title: 'New Product Review',
    subtitle: 'Amit S. left a 5-star review on JBL Speaker.',
    time: '2 hours ago',
    isRead: true,
    unreadCount: 0,
    icon: Icons.star_outline,
    iconBackgroundColor: AppColors.PrimaryColor, // Update to use AppColors
  ),
  Notification(
    id: '4',
    title: 'Payment Received',
    subtitle: 'Payment of ₹2,499 received for order #23-456-222.',
    time: 'Yesterday',
    isRead: true,
    unreadCount: 0,
    icon: Icons.payment,
    iconBackgroundColor: AppColors.PrimaryColor,
  ),
  Notification(
    id: '5',
    title: 'Delivery Completed',
    subtitle: 'Order #23-455-789 has been delivered successfully.',
    time: 'Yesterday',
    isRead: true,
    unreadCount: 0,
    icon: Icons.local_shipping_outlined,
    iconBackgroundColor: Colors.blue,
  ),
];