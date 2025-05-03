import 'package:flutter/material.dart';
import 'package:supr_driver/Utils/theme_Constants.dart';
import 'package:supr_driver/app/app_theme.dart';
import 'package:supr_driver/models/chat_data.dart';
import 'package:supr_driver/models/chat_model.dart';

class ChatDetailScreen extends StatefulWidget {
  final String conversationId;

  const ChatDetailScreen({
    Key? key,
    required this.conversationId,
  }) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late ChatConversation _conversation;
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();
  bool _showEmojiPicker = false;

  @override
  void initState() {
    super.initState();
    _conversation = ChatDataProvider.getConversation(widget.conversationId);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      // In a real app, you would send the message to your backend
      // For now, we're just clearing the input field
      _messageController.clear();
      
      // Hide emoji picker if open
      if (_showEmojiPicker) {
        setState(() {
          _showEmojiPicker = false;
        });
      }
      
      // Request focus to the text field to keep keyboard open
      _messageFocusNode.requestFocus();
    }
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
      if (_showEmojiPicker) {
        // Hide keyboard
        FocusScope.of(context).unfocus();
      } else {
        // Show keyboard
        _messageFocusNode.requestFocus();
      }
    });
  }

  void _openAttachmentPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildAttachmentSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: _buildMessageList(),
          ),
          
          // Emoji picker (conditionally shown)
          if (_showEmojiPicker)
            Container(
              height: 250,
              color: Colors.white,
              child: const Center(
                child: Text(
                  'Emoji Picker would be integrated here',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          
          // Message input field
          _buildMessageInput(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final participant = _conversation.participant;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.5,
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left_outlined,
          color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
          size: 30,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          // User avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: NetworkImage(participant.avatar),
          ),
          const SizedBox(width: 10),
          
          // Name and online status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    participant.name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                    ),
                  ),
                  const SizedBox(width: 5),
                  if (participant.isOnline)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                participant.isOnline ? 'Online' : 'Last seen recently',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        // Additional actions like call, video call, menu, etc.
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
          ),
          onPressed: () {
            // Show more options
          },
        ),
      ],
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      reverse: true, // So newest messages appear at the bottom
      itemCount: _conversation.messages.length,
      itemBuilder: (context, index) {
        // Reverse the index to show newest messages at the bottom
        final reversedIndex = _conversation.messages.length - 1 - index;
        final message = _conversation.messages[reversedIndex];
        final isMyMessage = message.senderId == ChatDataProvider.currentUserId;
        
        return _buildMessageBubble(
          message: message,
          isMyMessage: isMyMessage,
          showAvatar: !isMyMessage && (reversedIndex == 0 || 
            _conversation.messages[reversedIndex - 1].senderId != message.senderId),
        );
      },
    );
  }

  Widget _buildMessageBubble({
    required ChatMessage message,
    required bool isMyMessage,
    required bool showAvatar,
  }) {
    final time = ChatDataProvider.formatMessageTime(message.timestamp);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar for received messages
          if (!isMyMessage && showAvatar)
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: NetworkImage(_conversation.participant.avatar),
            )
          else if (!isMyMessage)
            const SizedBox(width: 32), // Space for alignment when avatar is not shown
            
          const SizedBox(width: 8),
          
          // Message bubble
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isMyMessage 
                    ? AppColors.PrimaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Message content
                  Text(
                    message.content,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: isMyMessage ? AppColors.SecondaryColor : Colors.black,
                    ),
                  ),
                  
                  const SizedBox(height: 2),
                  
                  // Message time and read status
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          color: isMyMessage 
                              ? Colors.white.withOpacity(0.7) 
                              : Colors.grey.shade500,
                        ),
                      ),
                      
                      if (isMyMessage) ...[
                        const SizedBox(width: 3),
                        Icon(
                          message.isRead ? Icons.done_all : Icons.done,
                          size: 12,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black45 : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, -1),
            blurRadius: 3,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Emoji button
            IconButton(
              icon: Icon(
                _showEmojiPicker ? Icons.keyboard : Icons.emoji_emotions_outlined,
                color: AppColors.PrimaryColor,
              ),
              onPressed: _toggleEmojiPicker,
            ),
            
            // Message input field
            Expanded(
              child: TextField(
                controller: _messageController,
                focusNode: _messageFocusNode,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 5,
              ),
            ),
            
            // Attachment button
            IconButton(
              icon: Icon(
                Icons.attach_file,
                color: AppColors.PrimaryColor,
              ),
              onPressed: _openAttachmentPicker,
            ),
            
            // Send button
            IconButton(
              icon: Icon(
                Icons.send,
                color: AppColors.PrimaryColor,
              ),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentSheet() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Share Files',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ThemeConstants.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAttachmentOption(
                icon: Icons.photo_library_outlined,
                label: 'Gallery',
                color: AppColors.PrimaryColor,
                onTap: () => Navigator.pop(context),
              ),
              _buildAttachmentOption(
                icon: Icons.camera_alt_outlined,
                label: 'Camera',
                color: AppColors.PrimaryColor,
                onTap: () => Navigator.pop(context),
              ),
              _buildAttachmentOption(
                icon: Icons.insert_drive_file_outlined,
                label: 'Document',
                color: AppColors.PrimaryColor,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: ThemeConstants.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}