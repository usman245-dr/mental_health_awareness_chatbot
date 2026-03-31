import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_awareness_chatbot/utils/include.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavShellWidget(
      currentRoute: RoutesName.aboutPage,
      child: _AboutPageContent(),
    );
  }
}

class _AboutPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBarWidget(
        title: 'About Mental Health',
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            ),
            onPressed: () =>
                context.read<ThemeBloc>().add(ThemeToggled()),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        // Hero
                        _buildHero(isDark),
                        const SizedBox(height: 32),
                        // Why it matters
                        _buildSection(
                          isDark,
                          title: 'Why Mental Health Matters',
                          icon: Icons.favorite_rounded,
                          color: AppColors.rose,
                          content:
                              'Mental health is a crucial part of overall well-being. '
                              'It affects how we think, feel, and act. Good mental health '
                              'helps us handle stress, relate to others, and make healthy '
                              'choices. Just like physical health, mental health deserves '
                              'attention and care at every stage of life.',
                        ),
                        const SizedBox(height: 20),
                        // Statistics
                        _buildStatistics(isDark),
                        const SizedBox(height: 20),
                        // Breaking stigma
                        _buildSection(
                          isDark,
                          title: 'Breaking the Stigma',
                          icon: Icons.campaign_rounded,
                          color: AppColors.lavender,
                          content:
                              'Mental health conditions are common and treatable. '
                              'Yet stigma prevents many people from seeking help. '
                              'By talking openly about mental health, we can:\n\n'
                              '• Normalize seeking professional help\n'
                              '• Support those who are struggling\n'
                              '• Create safer communities\n'
                              '• Reduce isolation and shame\n'
                              '• Encourage early intervention',
                        ),
                        const SizedBox(height: 20),
                        // Self-care
                        _buildSection(
                          isDark,
                          title: 'Daily Mental Wellness',
                          icon: Icons.spa_rounded,
                          color: AppColors.sage,
                          content:
                              'Small daily habits can significantly impact your mental health:\n\n'
                              '🌿 Move your body — even a short walk helps\n'
                              '💤 Prioritize sleep — aim for 7-9 hours\n'
                              '🥗 Eat nourishing foods\n'
                              '🧘 Practice mindfulness or meditation\n'
                              '👥 Stay connected with loved ones\n'
                              '📱 Limit social media consumption\n'
                              '📝 Journal your thoughts and gratitude\n'
                              '🎨 Engage in creative activities',
                        ),
                        const SizedBox(height: 20),
                        // About the app
                        _buildAppInfo(isDark),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHero(bool isDark) {
    return GlassCardWidget(
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Icon(
            Icons.psychology_rounded,
            size: 48,
            color: isDark ? AppColors.primaryLight : AppColors.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'About Mental Health',
            style: AppStyles.heading2.copyWith(
              color:
                  isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Mental health includes our emotional, psychological, and social well-being. '
            'It\'s about how we think, feel, act, handle stress, relate to others, '
            'and make choices. Mental health is important at every stage of life.',
            style: AppStyles.descriptionText.copyWith(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    bool isDark, {
    required String title,
    required IconData icon,
    required Color color,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: AppStyles.heading3.copyWith(
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: AppStyles.descriptionText.copyWith(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics(bool isDark) {
    final stats = [
      _StatItem('1 in 5', 'adults experience mental illness each year', AppColors.primary),
      _StatItem('50%', 'of mental health conditions begin by age 14', AppColors.lavender),
      _StatItem('60%', 'of people with mental illness don\'t receive treatment', AppColors.sage),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'Key Facts',
            style: AppStyles.heading3.copyWith(
              color:
                  isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
              fontSize: 18,
            ),
          ),
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: stats.map((stat) {
            return SizedBox(
              width: 220,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.border,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stat.value,
                      style: AppStyles.heading2.copyWith(
                        color: stat.color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stat.label,
                      style: AppStyles.bodySmall.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAppInfo(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkCard
            : AppColors.primaryLight.withAlpha(40),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.primaryLight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: isDark ? AppColors.primaryLight : AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'MindfulChat is designed to promote mental health awareness and emotional support. '
              'It does not provide medical diagnosis or replace professional therapy. '
              'If you need professional help, please consult a licensed mental health professional.',
              style: AppStyles.bodySmall.copyWith(
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem {
  final String value;
  final String label;
  final Color color;

  const _StatItem(this.value, this.label, this.color);
}
