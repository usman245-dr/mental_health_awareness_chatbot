import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_awareness_chatbot/utils/include.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavShellWidget(
      currentRoute: RoutesName.contactPage,
      child: _ContactPageContent(),
    );
  }
}

class _ContactPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Help & Support',
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
                        // Emergency banner
                        _buildEmergencyBanner(isDark),
                        const SizedBox(height: 24),
                        // Crisis hotlines
                        Text(
                          'Crisis Support Lines',
                          style: AppStyles.heading3.copyWith(
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildHotlineCard(
                          isDark,
                          title: '988 Suicide & Crisis Lifeline',
                          description:
                              'Free, confidential 24/7 support for people in distress.',
                          action: 'Call or text 988',
                          icon: Icons.phone_rounded,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 12),
                        _buildHotlineCard(
                          isDark,
                          title: 'Crisis Text Line',
                          description:
                              'Free crisis counseling via text message, 24/7.',
                          action: 'Text HOME to 741741',
                          icon: Icons.textsms_rounded,
                          color: AppColors.sage,
                        ),
                        const SizedBox(height: 12),
                        _buildHotlineCard(
                          isDark,
                          title: 'NAMI Helpline',
                          description:
                              'Information and referral for mental health support.',
                          action: 'Call 1-800-950-NAMI (6264)',
                          icon: Icons.support_agent_rounded,
                          color: AppColors.lavender,
                        ),
                        const SizedBox(height: 12),
                        _buildHotlineCard(
                          isDark,
                          title: 'SAMHSA National Helpline',
                          description:
                              'Treatment referral and information service.',
                          action: 'Call 1-800-662-4357',
                          icon: Icons.local_hospital_rounded,
                          color: AppColors.peach,
                        ),
                        const SizedBox(height: 32),
                        // Finding a therapist
                        Text(
                          'Finding Professional Help',
                          style: AppStyles.heading3.copyWith(
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildTipCard(
                          isDark,
                          tips: [
                            'Ask your doctor for a referral to a therapist or counselor.',
                            'Check with your insurance provider for covered mental health services.',
                            'Many therapists offer sliding-scale fees based on income.',
                            'Online therapy platforms can provide accessible support.',
                            'University clinics often offer low-cost services.',
                            'Community mental health centers provide services regardless of ability to pay.',
                          ],
                        ),
                        const SizedBox(height: 32),
                        // What to do in crisis
                        Text(
                          'What To Do in a Crisis',
                          style: AppStyles.heading3.copyWith(
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildCrisisSteps(isDark),
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

  Widget _buildEmergencyBanner(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkCrisisBackground
            : AppColors.crisisBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.crisis, width: 1.5),
      ),
      child: Column(
        children: [
          const Icon(Icons.emergency_rounded,
              color: AppColors.crisis, size: 36),
          const SizedBox(height: 12),
          Text(
            'If you are in immediate danger, call 911',
            style: AppStyles.heading3.copyWith(
              color: AppColors.crisis,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'If you or someone you know is experiencing a mental health crisis, '
            'please reach out to one of the resources below. You are not alone.',
            style: AppStyles.bodySmall.copyWith(
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

  Widget _buildHotlineCard(
    bool isDark, {
    required String title,
    required String description,
    required String action,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.cardTitle.copyWith(
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppStyles.bodySmall.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  action,
                  style: AppStyles.buttonTextSmall.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(bool isDark, {required List<String> tips}) {
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
        children: tips.asMap().entries.map((entry) {
          return Padding(
            padding: EdgeInsets.only(bottom: entry.key < tips.length - 1 ? 12 : 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    entry.value,
                    style: AppStyles.descriptionText.copyWith(
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCrisisSteps(bool isDark) {
    final steps = [
      _CrisisStep('1', 'Stay Calm',
          'Take slow, deep breaths. Try to stay as calm as possible.'),
      _CrisisStep('2', 'Reach Out',
          'Call 988, text HOME to 741741, or contact emergency services.'),
      _CrisisStep('3', 'Stay Safe',
          'Remove yourself from any immediate danger. Go to a safe place.'),
      _CrisisStep('4', 'Talk to Someone',
          'Reach out to a trusted friend, family member, or counselor.'),
      _CrisisStep('5', 'Follow Up',
          'After the crisis passes, seek ongoing professional support.'),
    ];

    return Column(
      children: steps.map((step) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.border,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.primaryDark
                        : AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    step.number,
                    style: AppStyles.buttonTextSmall.copyWith(
                      color: isDark ? AppColors.white : AppColors.primaryDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.title,
                        style: AppStyles.cardTitle.copyWith(
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        step.description,
                        style: AppStyles.bodySmall.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _CrisisStep {
  final String number;
  final String title;
  final String description;

  const _CrisisStep(this.number, this.title, this.description);
}
