enum MessageType { text, image, url }

class Message {
  MessageType type;
  String content;
  bool isSelected;

  Message({required this.type, required this.content, this.isSelected = false});
}