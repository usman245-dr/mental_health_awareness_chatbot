import 'package:equatable/equatable.dart';
import 'package:mental_health_awareness_chatbot/model/message.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> messages;
  final bool isTyping;

  const ChatLoaded({
    required this.messages,
    this.isTyping = false,
  });

  ChatLoaded copyWith({
    List<Message>? messages,
    bool? isTyping,
  }) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }

  @override
  List<Object?> get props => [messages, isTyping];
}
