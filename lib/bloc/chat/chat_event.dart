import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class ChatSendMessage extends ChatEvent {
  final String message;

  const ChatSendMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatSelectTopic extends ChatEvent {
  final String topic;

  const ChatSelectTopic(this.topic);

  @override
  List<Object?> get props => [topic];
}

class ChatStarted extends ChatEvent {}
