class Chat {
  final String id;
  final String lastMessage;
  final Members members;
  final String name;
  final int timestamp;

  Chat({
    required this.id,
    required this.lastMessage,
    required this.members,
    required this.name,
    required this.timestamp,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'] as String,
      lastMessage: json['last_message'] as String,
      members: Members.fromJson(json['members'] as Map<String, dynamic>),
      name: json['name'] as String,
      timestamp: json['timestamp'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'last_message': lastMessage,
      'members': members.toJson(),
      'name': name,
      'timestamp': timestamp,
    };
  }
}

class Members {
  final Map<String, bool> userMemberships;

  Members({required this.userMemberships});

  factory Members.fromJson(Map<String, dynamic> json) {
    return Members(userMemberships: Map<String, bool>.from(json));
  }

  Map<String, dynamic> toJson() {
    return userMemberships;
  }
}

class ChatMessage {
  final String id;
  final bool read;
  final String receiver;
  final String sender;
  final int timestamp;
  final String text;
  final String? imageUrl;

  ChatMessage({
    required this.id,
    required this.read,
    required this.receiver,
    required this.sender,
    required this.timestamp,
    required this.text,
    this.imageUrl = "",
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      read: json['read'] as bool,
      receiver: json['receiver'] as String,
      sender: json['sender'] as String,
      timestamp: json['timestamp'] as int,
      text: json['text'] as String,
      imageUrl: json['image_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'read': read,
      'receiver': receiver,
      'sender': sender,
      'timestamp': timestamp,
      'text': text,
      'image_url': imageUrl,
    };
  }
}
