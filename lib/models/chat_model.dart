class ChatUser {
  final String id;
  final String name;
  final String avatar;
  final bool isOnline;
  final DateTime lastSeen;

  ChatUser({
    required this.id,
    required this.name,
    required this.avatar,
    this.isOnline = false,
    required this.lastSeen,
  });
}

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final bool isRead;
  final MessageType type;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    this.isRead = false,
    this.type = MessageType.text,
  });
}

class ChatConversation {
  final String id;
  final ChatUser participant;
  final List<ChatMessage> messages;
  final DateTime lastMessageTime;
  final int unreadCount;

  ChatConversation({
    required this.id,
    required this.participant,
    required this.messages,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });

  String get lastMessage {
    if (messages.isEmpty) return '';
    return messages.last.content;
  }
}

enum MessageType {
  text,
  image,
  file,
  voice,
  video,
}