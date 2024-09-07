class Message {
  final String message;
  final String senderId; // Add this field

  Message(this.message, this.senderId);

  factory Message.fromJson(json) {
    return Message(
      json['message'],
      json['senderId'],
    );
  }
}
