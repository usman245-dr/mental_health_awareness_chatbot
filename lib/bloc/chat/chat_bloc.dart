import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_awareness_chatbot/bloc/chat/chat_event.dart';
import 'package:mental_health_awareness_chatbot/bloc/chat/chat_state.dart';
import 'package:mental_health_awareness_chatbot/model/message.dart';
import 'package:mental_health_awareness_chatbot/repository/chat_repository.dart';
import 'package:mental_health_awareness_chatbot/utils/constants.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;

  ChatBloc({required ChatRepository chatRepository})
      : _chatRepository = chatRepository,
        super(ChatInitial()) {
    on<ChatStarted>(_onStarted);
    on<ChatSendMessage>(_onSendMessage);
    on<ChatSelectTopic>(_onSelectTopic);
  }

  void _onStarted(ChatStarted event, Emitter<ChatState> emit) {
    final welcomeMessage = Message(
      id: 'welcome',
      text: AppConstants.welcomeMessage,
      sender: MessageSender.bot,
      timestamp: DateTime.now(),
    );
    emit(ChatLoaded(messages: [welcomeMessage]));
  }

  Future<void> _onSendMessage(
    ChatSendMessage event,
    Emitter<ChatState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ChatLoaded) return;

    final userMessage = Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: event.message,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    // Add user message and show typing indicator
    emit(currentState.copyWith(
      messages: [...currentState.messages, userMessage],
      isTyping: true,
    ));

    // Get bot response
    final botMessage = await _chatRepository.getBotResponse(event.message);

    final updatedState = state as ChatLoaded;
    emit(updatedState.copyWith(
      messages: [...updatedState.messages, botMessage],
      isTyping: false,
    ));
  }

  Future<void> _onSelectTopic(
    ChatSelectTopic event,
    Emitter<ChatState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ChatLoaded) return;

    final topicMessage = Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: 'Tell me about ${event.topic}',
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    emit(currentState.copyWith(
      messages: [...currentState.messages, topicMessage],
      isTyping: true,
    ));

    final botMessage = await _chatRepository.getTopicResponse(event.topic);

    final updatedState = state as ChatLoaded;
    emit(updatedState.copyWith(
      messages: [...updatedState.messages, botMessage],
      isTyping: false,
    ));
  }
}
