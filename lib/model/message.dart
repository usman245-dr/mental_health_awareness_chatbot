import 'package:equatable/equatable.dart';

enum MessageSender { user, bot }

class Message extends Equatable {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;
  final bool isCrisisResponse;

  const Message({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.isCrisisResponse = false,
  });

  @override
  List<Object?> get props => [id, text, sender, timestamp, isCrisisResponse];
}
