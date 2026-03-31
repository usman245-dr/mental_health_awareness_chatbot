import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_awareness_chatbot/utils/include.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavShellWidget(
      currentRoute: RoutesName.resourcesPage,
      child: _ResourcesPageContent(),
    );
  }
}

class _ResourcesPageContent extends StatelessWidget {
  static const _resources = [
    _ResourceCategory(
      title: 'Understanding Anxiety',
      icon: Icons.psychology_outlined,
      color: AppColors.primary,
      items: [
        _ResourceItem(
          title: 'What is Anxiety?',
          description:
              'Anxiety is your body\'s natural response to stress. It\'s a feeling '
              'of fear or apprehension about what\'s to come. While occasional anxiety '
              'is normal, persistent anxiety may indicate an anxiety disorder.',
        ),
        _ResourceItem(
          title: 'Common Symptoms',
          description:
              '• Rapid heartbeat or breathing\n• Excessive worry\n'
              '• Difficulty concentrating\n• Restlessness or irritability\n'
              '• Sleep difficulties\n• Muscle tension',
        ),
        _ResourceItem(
          title: 'Coping Strategies',
          description:
              '• Practice deep breathing exercises\n• Challenge negative thoughts\n'
              '• Limit caffeine and alcohol\n• Exercise regularly\n'
              '• Maintain a consistent sleep schedule\n• Talk to someone you trust',
        ),
      ],
    ),
    _ResourceCategory(
      title: 'Understanding Depression',
      icon: Icons.cloud_outlined,
      color: AppColors.lavender,
      items: [
        _ResourceItem(
          title: 'What is Depression?',
          description:
              'Depression is more than just feeling sad. It\'s a persistent mood '
              'disorder that affects how you feel, think, and handle daily activities. '
              'It can happen to anyone and is not a sign of weakness.',
        ),
        _ResourceItem(
          title: 'Common Signs',
          description:
              '• Persistent sad or empty feelings\n• Loss of interest in activities\n'
              '• Changes in appetite or weight\n• Sleep disturbances\n'
              '• Fatigue or low energy\n• Difficulty concentrating',
        ),
        _ResourceItem(
          title: 'Getting Help',
          description:
              '• Talk to your doctor or a mental health professional\n'
              '• Reach out to trusted friends or family\n'
              '• Consider therapy (CBT, talk therapy)\n'
              '• Stay connected with others\n'
              '• Maintain daily routines\n'
              '• Be patient with yourself — recovery takes time',
        ),
      ],
    ),
    _ResourceCategory(
      title: 'Stress Management',
      icon: Icons.self_improvement_rounded,
      color: AppColors.sage,
      items: [
        _ResourceItem(
          title: 'Healthy Coping Methods',
          description:
              '• Regular physical activity\n• Mindfulness and meditation\n'
              '• Time management and prioritization\n• Creative expression\n'
              '• Social connection\n• Adequate rest and nutrition',
        ),
        _ResourceItem(
          title: 'Quick Stress Relievers',
          description:
              '• Box breathing (4-4-4-4)\n• Progressive muscle relaxation\n'
              '• 5-minute walk outside\n• Listen to calming music\n'
              '• Write in a journal\n• Stretch your body',
        ),
      ],
    ),
    _ResourceCategory(
      title: 'Mindfulness & Meditation',
      icon: Icons.spa_rounded,
      color: AppColors.peach,
      items: [
        _ResourceItem(
          title: 'Getting Started',
          description:
              'Mindfulness is the practice of paying attention to the present moment '
              'without judgment. Start with just 2-3 minutes daily and gradually increase. '
              'There\'s no "right" way — simply notice your thoughts and let them pass.',
        ),
        _ResourceItem(
          title: 'Simple Exercises',
          description:
              '• Body scan meditation\n• Mindful breathing\n'
              '• Walking meditation\n• Gratitude journaling\n'
              '• Mindful eating\n• 5-4-3-2-1 grounding technique',
        ),
      ],
    ),
    _ResourceCategory(
      title: 'Sleep Health',
      icon: Icons.bedtime_rounded,
      color: AppColors.primaryDark,
      items: [
        _ResourceItem(
          title: 'Sleep Hygiene Tips',
          description:
              '• Keep a consistent sleep schedule\n'
              '• Create a relaxing bedtime routine\n'
              '• Make your bedroom cool, dark, and quiet\n'
              '• Limit screen time before bed\n'
              '• Avoid caffeine after 2 PM\n'
              '• Exercise during the day, not before bed',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Resources',
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
                        Text(
                          'Mental Health Resources',
                          style: AppStyles.heading2.copyWith(
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Educational information to help you understand and support mental wellness.',
                          style: AppStyles.descriptionText.copyWith(
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ..._resources.map((category) =>
                            _buildCategory(category, isDark)),
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

  Widget _buildCategory(_ResourceCategory category, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: category.color.withAlpha(30),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(category.icon, color: category.color, size: 22),
        ),
        title: Text(
          category.title,
          style: AppStyles.cardTitle.copyWith(
            color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.border,
          ),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.border,
          ),
        ),
        backgroundColor: isDark ? AppColors.darkCard : AppColors.surface,
        collapsedBackgroundColor:
            isDark ? AppColors.darkCard : AppColors.surface,
        children: category.items
            .map((item) => _buildResourceItem(item, isDark))
            .toList(),
      ),
    );
  }

  Widget _buildResourceItem(_ResourceItem item, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkBackground : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: AppStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.description,
              style: AppStyles.descriptionText.copyWith(
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResourceCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<_ResourceItem> items;

  const _ResourceCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });
}

class _ResourceItem {
  final String title;
  final String description;

  const _ResourceItem({
    required this.title,
    required this.description,
  });
}
