import 'dart:io';

enum MessageType {
  user,
  ai,
  error,
}

class ChatMessage {
  final String text;
  final MessageType type;
  final File? image;

  ChatMessage({
    required this.text,
    required this.type,
    this.image,
  });
}