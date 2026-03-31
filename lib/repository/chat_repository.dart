import 'package:mental_health_awareness_chatbot/model/message.dart';
import 'package:mental_health_awareness_chatbot/services/chatbot_service.dart';

/// Repository layer between BLoC and ChatbotService
class ChatRepository {
  final ChatbotService _chatbotService;

  ChatRepository({ChatbotService? chatbotService})
      : _chatbotService = chatbotService ?? ChatbotService();

  /// Process user message and return bot response
  Future<Message> getBotResponse(String userMessage) async {
    // Simulate brief thinking delay for natural feel
    await Future.delayed(const Duration(milliseconds: 800));

    final result = _chatbotService.getResponse(userMessage);
    return Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: result.response,
      sender: MessageSender.bot,
      timestamp: DateTime.now(),
      isCrisisResponse: result.isCrisis,
    );
  }

  /// Get response for a suggested topic
  Future<Message> getTopicResponse(String topic) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final response = _chatbotService.getTopicResponse(topic);
    return Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: response,
      sender: MessageSender.bot,
      timestamp: DateTime.now(),
    );
  }
}
