import 'package:flutter/material.dart';
import 'package:mental_health_awareness_chatbot/resources/styles/app_colors.dart';
import 'package:mental_health_awareness_chatbot/resources/styles/app_styles.dart';

class TopicCardWidget extends StatelessWidget {
  final String title;
  final String emoji;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const TopicCardWidget({
    super.key,
    required this.title,
    required this.emoji,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: backgroundColor ??
                (isDark ? AppColors.darkCard : AppColors.surface),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  title,
                  style: AppStyles.buttonTextSmall.copyWith(
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
