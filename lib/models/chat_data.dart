import 'package:supr_driver/models/chat_model.dart';

class ChatDataProvider {
  // Current user ID (you as the seller)
  static const String currentUserId = 'seller_123';

  static final List<ChatUser> _users = [
    ChatUser(
      id: 'user_1',
      name: 'Priya Sharma',
      avatar: 'https://randomuser.me/api/portraits/women/44.jpg',
      isOnline: true,
      lastSeen: DateTime.now(),
    ),
    ChatUser(
      id: 'user_2',
      name: 'Rahul Patel',
      avatar: 'https://randomuser.me/api/portraits/men/32.jpg',
      isOnline: false,
      lastSeen: DateTime.now().subtract(const Duration(minutes: 35)),
    ),
    ChatUser(
      id: 'user_3',
      name: 'Ananya Singh',
      avatar: 'https://randomuser.me/api/portraits/women/68.jpg',
      isOnline: true,
      lastSeen: DateTime.now(),
    ),
  ];

  static final Map<String, List<ChatMessage>> _messages = {
    'conv_1': [
      ChatMessage(
        id: 'm1',
        senderId: 'user_1',
        receiverId: currentUserId,
        content: 'Hi, I wanted to check if the wireless earbuds are in stock?',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        isRead: true,
      ),
      ChatMessage(
        id: 'm2',
        senderId: currentUserId,
        receiverId: 'user_1',
        content: 'Yes, we have both black and white models available.',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1, minutes: 45)),
        isRead: true,
      ),
      ChatMessage(
        id: 'm3',
        senderId: 'user_1',
        receiverId: currentUserId,
        content: 'Great! What\'s the price for the black ones?',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1, minutes: 30)),
        isRead: true,
      ),
      ChatMessage(
        id: 'm4',
        senderId: currentUserId,
        receiverId: 'user_1',
        content: 'The black ones are ₹2,499, but we have a special offer this week - ₹1,999 only!',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
        isRead: true,
      ),
      ChatMessage(
        id: 'm5',
        senderId: 'user_1',
        receiverId: currentUserId,
        content: 'That\'s a great deal! Can you hold one for me? I\'ll come by tomorrow.',
        timestamp: DateTime.now().subtract(const Duration(hours: 23)),
        isRead: false,
      ),
    ],
    'conv_2': [
      ChatMessage(
        id: 'm6',
        senderId: 'user_2',
        receiverId: currentUserId,
        content: 'Hello, do you provide installation services for home appliances?',
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 5)),
        isRead: true,
      ),
      ChatMessage(
        id: 'm7',
        senderId: currentUserId,
        receiverId: 'user_2',
        content: 'Yes, we do. We provide installation for all major appliances.',
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 4)),
        isRead: true,
      ),
      ChatMessage(
        id: 'm8',
        senderId: 'user_2',
        receiverId: currentUserId,
        content: 'How much would it cost to install an AC and a refrigerator?',
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
        isRead: true,
      ),
      ChatMessage(
        id: 'm9',
        senderId: currentUserId,
        receiverId: 'user_2',
        content: 'AC installation is ₹1,500 and refrigerator is ₹800. If you get both done together, we can offer a discount.',
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 2)),
        isRead: true,
      ),
      ChatMessage(
        id: 'm10',
        senderId: 'user_2',
        receiverId: currentUserId,
        content: 'That sounds good. What would be the total cost with the discount?',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: false,
      ),
      ChatMessage(
        id: 'm11',
        senderId: 'user_2',
        receiverId: currentUserId,
        content: 'Also, can you do it this Saturday?',
        timestamp: DateTime.now().subtract(const Duration(hours: 4, minutes: 55)),
        isRead: false,
      ),
    ],
    'conv_3': [
      ChatMessage(
        id: 'm12',
        senderId: 'user_3',
        receiverId: currentUserId,
        content: 'I want to return the power bank I purchased yesterday. It\'s not working properly.',
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
        isRead: true,
      ),
      ChatMessage(
        id: 'm13',
        senderId: currentUserId,
        receiverId: 'user_3',
        content: "I'm sorry to hear that. Could you please describe the issue you're facing?",
        timestamp: DateTime.now().subtract(const Duration(hours: 7, minutes: 45)),
        isRead: true,
      ),
      ChatMessage(
        id: 'm14',
        senderId: 'user_3',
        receiverId: currentUserId,
        content: "It's not charging fully and shuts down after a few minutes of use.",
        timestamp: DateTime.now().subtract(const Duration(hours: 7, minutes: 30)),
        isRead: true,
      ),
      ChatMessage(
        id: 'm15',
        senderId: currentUserId,
        receiverId: 'user_3',
        content: 'I understand. You can visit our store with the receipt for an immediate replacement or refund.',
        timestamp: DateTime.now().subtract(const Duration(hours: 7)),
        isRead: true,
      ),
      ChatMessage(
        id: 'm16',
        senderId: 'user_3',
        receiverId: currentUserId,
        content: "Perfect. I'll come by today evening.",
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
      ),
    ],
  };

  // Get all conversations
  static List<ChatConversation> getConversations() {
    return [
      ChatConversation(
        id: 'conv_1',
        participant: _users[0],
        messages: _messages['conv_1'] ?? [],
        lastMessageTime: (_messages['conv_1']?.last.timestamp ?? DateTime.now()),
        unreadCount: _messages['conv_1']?.where((m) => !m.isRead && m.senderId != currentUserId).length ?? 0,
      ),
      ChatConversation(
        id: 'conv_2',
        participant: _users[1],
        messages: _messages['conv_2'] ?? [],
        lastMessageTime: (_messages['conv_2']?.last.timestamp ?? DateTime.now()),
        unreadCount: _messages['conv_2']?.where((m) => !m.isRead && m.senderId != currentUserId).length ?? 0,
      ),
      ChatConversation(
        id: 'conv_3',
        participant: _users[2],
        messages: _messages['conv_3'] ?? [],
        lastMessageTime: (_messages['conv_3']?.last.timestamp ?? DateTime.now()),
        unreadCount: _messages['conv_3']?.where((m) => !m.isRead && m.senderId != currentUserId).length ?? 0,
      ),
    ];
  }

  // Get a specific conversation
  static ChatConversation getConversation(String id) {
    final conversation = getConversations().firstWhere(
      (conv) => conv.id == id,
      orElse: () => ChatConversation(
        id: id,
        participant: ChatUser(
          id: 'unknown',
          name: 'Unknown User',
          avatar: 'https://randomuser.me/api/portraits/lego/1.jpg',
          lastSeen: DateTime.now(),
        ),
        messages: [],
        lastMessageTime: DateTime.now(),
      ),
    );
    return conversation;
  }

  // Format timestamp for display
  static String formatMessageTime(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final messageDate = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (messageDate == today) {
      // Today, show time only
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == yesterday) {
      // Yesterday
      return 'Yesterday';
    } else {
      // Other days, show date
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}