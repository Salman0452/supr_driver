import 'package:flutter/material.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';
import 'package:intl/intl.dart';
import 'package:supr_driver/app/app_theme.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({Key? key}) : super(key: key);

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // Sample messages for demonstration
  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'support',
      'message': 'Hello! How can I help you today?',
      'time': DateTime.now().subtract(Duration(minutes: 5)),
    },
    {
      'sender': 'user',
      'message': 'Hello Rajesh, I have a question about my recent order.',
      'time': DateTime.now().subtract(Duration(minutes: 3)),
    },
    {
      'sender': 'support',
      'message': 'Sure, I\'d be happy to help. Could you provide your order ID?',
      'time': DateTime.now().subtract(Duration(minutes: 1)),
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Supr Customer Care",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.verified_rounded,
                    color: Colors.green,
                    size: 16,
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Online",
                    style: TextStyle(
                      fontSize: 12,
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          // Message list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage = message['sender'] == 'user';
                
                return _buildMessageItem(
                  message: message['message'],
                  time: message['time'],
                  isUserMessage: isUserMessage,
                );
              },
            ),
          ),
          
          // Message input field
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDarkMode ? Color(0xFF252525) : Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -1),
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.05),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Attachment button
                  IconButton(
                    icon: Icon(
                      Icons.attach_file,
                      color: AppColors.PrimaryColor,
                    ),
                    onPressed: () {},
                  ),
                  // Text field
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Color(0xFF303030) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _messageController,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          hintStyle: TextStyle(
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(width: 10),
                  
                  // Send button
                  GestureDetector(
                    onTap: () {
                      _sendMessage();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.PrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem({
    required String message,
    required DateTime time,
    required bool isUserMessage,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 16,
          left: isUserMessage ? 64 : 0,
          right: isUserMessage ? 0 : 64,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUserMessage
              ? AppColors.PrimaryColor
              : isDarkMode ? Color(0xFF3A3A3A) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isUserMessage
                    ? Colors.black
                    : isDarkMode ? Colors.white : Colors.black87,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4),
            Text(
              DateFormat('hh:mm a').format(time),
              style: TextStyle(
                color: isUserMessage
                    ? Colors.black.withOpacity(0.7)
                    : isDarkMode ? Colors.grey[400] : Colors.grey[600],
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add({
        'sender': 'user',
        'message': _messageController.text.trim(),
        'time': DateTime.now(),
      });
      
      _messageController.clear();
    });
    
    // Scroll to bottom after sending message
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
    
    // Simulate reply from support
    Future.delayed(Duration(seconds: 1), () {
      if (!mounted) return;
      
      setState(() {
        _messages.add({
          'sender': 'support',
          'message': "Thank you for reaching out. Our support team will assist you shortly.",
          'time': DateTime.now(),
        });
      });
      
      // Scroll to bottom after receiving reply
      Future.delayed(Duration(milliseconds: 100), () {
        if (!mounted) return;
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }
}
