import 'package:flutter/material.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';
import 'package:supr_driver/app/app.dart';
import 'package:supr_driver/app/app_theme.dart';
import 'package:supr_driver/models/chat_data.dart';
import 'package:supr_driver/models/chat_model.dart';
import 'package:supr_driver/screens/chat/chat_detail_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late List<ChatConversation> _conversations;
  final TextEditingController _searchController = TextEditingController();
  List<ChatConversation> _filteredConversations = [];

  @override
  void initState() {
    super.initState();
    _conversations = ChatDataProvider.getConversations();
    _filteredConversations = List.from(_conversations);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter conversations based on search query
  void _filterConversations(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredConversations = List.from(_conversations);
      } else {
        _filteredConversations = _conversations
            .where((conversation) => conversation.participant.name
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
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
          'Chats',
          style: TextStyle(
            color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Column(
        children: [
          // Search and filter bar
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black45 : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.PrimaryColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Search input
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _filterConversations,
                      decoration: const InputDecoration(
                        hintText: 'Search for chats...',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 5,
                        ),
                      ),
                    ),
                  ),
                  // Preferences/Filter button
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.PrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.tune,
                        color: AppColors.SecondaryColor,
                      ),
                      onPressed: () {
                        // Show filter options
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => _buildFilterSheet(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Chat list
          Expanded(
            child: _filteredConversations.isEmpty
                ? const Center(child: Text("No conversations found"))
                : ListView.builder(
                    itemCount: _filteredConversations.length,
                    itemBuilder: (context, index) {
                      final conversation = _filteredConversations[index];
                      return _buildChatListItem(conversation);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatListItem(ChatConversation conversation) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final unreadCount = conversation.unreadCount;
    final lastMessageTime = ChatDataProvider.formatMessageTime(
      conversation.lastMessageTime,
    );

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(
              conversationId: conversation.id,
            ),
          ),
        );
      },
      splashColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // User avatar
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: NetworkImage(conversation.participant.avatar),
            ),
            const SizedBox(width: 16),
            // Message details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and time row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        conversation.participant.name,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                        ),
                      ),
                      Text(
                        lastMessageTime,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: unreadCount > 0
                              ? isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Message preview and unread count row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessage,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight:
                                unreadCount > 0 ? FontWeight.w500 : FontWeight.w400,
                            color: unreadCount > 0
                                ? (isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor)
                                : Colors.grey.shade600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unreadCount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.PrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            unreadCount.toString(),
                            style: TextStyle(
                              color: AppColors.SecondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSheet() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sort conversations by',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildFilterOption(
            title: 'Most Recent',
            isSelected: true,
            onTap: () => Navigator.pop(context),
          ),
          _buildFilterOption(
            title: 'Unread First',
            onTap: () {
              setState(() {
                _filteredConversations.sort(
                  (a, b) => b.unreadCount.compareTo(a.unreadCount),
                );
              });
              Navigator.pop(context);
            },
          ),
          _buildFilterOption(
            title: 'Alphabetical',
            onTap: () {
              setState(() {
                _filteredConversations.sort(
                  (a, b) => a.participant.name.compareTo(b.participant.name),
                );
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption({
    required String title,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor : (isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor),
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: isDarkMode ? AppColors.PrimaryColor : AppColors.SecondaryColor,
            )
          : null,
      onTap: onTap,
    );
  }
}