import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_awareness_chatbot/utils/include.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavShellWidget(
      currentRoute: RoutesName.homePage,
      child: _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarWidget(
        title: AppConstants.appName,
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
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      // Hero section
                      _buildHeroSection(isDark, screenWidth),
                      const SizedBox(height: 40),
                      // Quick actions
                      _buildQuickActions(context, isDark, screenWidth),
                      const SizedBox(height: 40),
                      // Features section
                      _buildFeaturesSection(isDark, screenWidth),
                      const SizedBox(height: 40),
                      // Disclaimer
                      _buildDisclaimer(isDark),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroSection(bool isDark, double screenWidth) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: GlassCardWidget(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.primaryDark.withAlpha(60)
                      : AppColors.primaryLight.withAlpha(100),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.spa_rounded,
                  size: 48,
                  color: isDark ? AppColors.primaryLight : AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to MindfulChat',
                style: (screenWidth > 600
                        ? AppStyles.heading1
                        : AppStyles.heading2)
                    .copyWith(
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                AppConstants.appTagline,
                style: AppStyles.bodyLarge.copyWith(
                  color: isDark ? AppColors.lavenderLight : AppColors.lavender,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                AppConstants.appDescription,
                style: AppStyles.descriptionText.copyWith(
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(
      BuildContext context, bool isDark, double screenWidth) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get Started',
              style: AppStyles.heading3.copyWith(
                color:
                    isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _QuickActionButton(
                  icon: Icons.chat_bubble_rounded,
                  label: 'Start Chatting',
                  color: AppColors.primary,
                  onTap: () => Navigator.pushReplacementNamed(
                      context, RoutesName.chatPage),
                ),
                _QuickActionButton(
                  icon: Icons.menu_book_rounded,
                  label: 'Browse Resources',
                  color: AppColors.sage,
                  onTap: () => Navigator.pushReplacementNamed(
                      context, RoutesName.resourcesPage),
                ),
                _QuickActionButton(
                  icon: Icons.self_improvement_rounded,
                  label: 'Breathing Exercise',
                  color: AppColors.lavender,
                  onTap: () => Navigator.pushReplacementNamed(
                      context, RoutesName.chatPage),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(bool isDark, double screenWidth) {
    final features = [
      _FeatureInfo(
        icon: Icons.psychology_rounded,
        title: 'Emotional Support',
        description: 'Get empathetic responses and feel heard in a safe space.',
        color: AppColors.primary,
      ),
      _FeatureInfo(
        icon: Icons.spa_rounded,
        title: 'Mindfulness',
        description:
            'Guided breathing exercises and meditation techniques.',
        color: AppColors.sage,
      ),
      _FeatureInfo(
        icon: Icons.lightbulb_rounded,
        title: 'Awareness',
        description:
            'Learn about mental health topics in simple, clear language.',
        color: AppColors.lavender,
      ),
      _FeatureInfo(
        icon: Icons.shield_rounded,
        title: 'Safety First',
        description:
            'Crisis resources and professional help when you need it most.',
        color: AppColors.rose,
      ),
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How We Can Help',
              style: AppStyles.heading3.copyWith(
                color:
                    isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth > 600 ? 2 : 1,
                childAspectRatio: screenWidth > 600 ? 2.2 : 3.0,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: features.length,
              itemBuilder: (context, index) =>
                  _buildFeatureCard(features[index], isDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(_FeatureInfo feature, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: feature.color.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(feature.icon, color: feature.color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  feature.title,
                  style: AppStyles.cardTitle.copyWith(
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feature.description,
                  style: AppStyles.cardSubtitle.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimer(bool isDark) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Container(
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
                  AppConstants.disclaimer,
                  style: AppStyles.bodySmall.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
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

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(60),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.white, size: 20),
              const SizedBox(width: 10),
              Text(label, style: AppStyles.buttonText),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureInfo {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureInfo({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
