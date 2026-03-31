import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_awareness_chatbot/model/message.dart';
import 'package:mental_health_awareness_chatbot/resources/styles/app_colors.dart';
import 'package:mental_health_awareness_chatbot/resources/styles/app_styles.dart';

class ChatBubbleWidget extends StatelessWidget {
  final Message message;

  const ChatBubbleWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = screenWidth > 600 ? 500.0 : screenWidth * 0.75;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: isDark ? AppColors.primaryDark : AppColors.primaryLight,
              child: const Icon(Icons.spa, size: 18, color: AppColors.white),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: _getBubbleColor(isUser, isDark),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isUser ? 18 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 18),
                ),
                border: message.isCrisisResponse
                    ? Border.all(color: AppColors.crisis, width: 1.5)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(isDark ? 20 : 8),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.isCrisisResponse)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.warning_amber_rounded,
                              color: AppColors.crisis, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'Support Resources',
                            style: AppStyles.bodySmall.copyWith(
                              color: AppColors.crisis,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  _buildFormattedText(message.text, isUser, isDark),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('h:mm a').format(message.timestamp),
                    style: AppStyles.chatTimestamp.copyWith(
                      color: isUser
                          ? AppColors.white.withAlpha(180)
                          : (isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.textHint),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }

  Color _getBubbleColor(bool isUser, bool isDark) {
    if (message.isCrisisResponse) {
      return isDark ? AppColors.darkCrisisBackground : AppColors.crisisBackground;
    }
    if (isUser) {
      return isDark ? AppColors.darkUserBubble : AppColors.userBubble;
    }
    return isDark ? AppColors.darkBotBubble : AppColors.botBubble;
  }

  Widget _buildFormattedText(String text, bool isUser, bool isDark) {
    // Simple markdown-like bold text support
    final spans = <InlineSpan>[];
    final boldPattern = RegExp(r'\*\*(.*?)\*\*');
    int lastEnd = 0;

    for (final match in boldPattern.allMatches(text)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(fontWeight: FontWeight.w700),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }

    return RichText(
      text: TextSpan(
        style: AppStyles.chatMessage.copyWith(
          color: isUser
              ? AppColors.white
              : (isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
        ),
        children: spans.isEmpty ? [TextSpan(text: text)] : spans,
      ),
    );
  }
}
