import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_awareness_chatbot/bloc/shared/theme/theme_bloc.dart';
import 'package:mental_health_awareness_chatbot/bloc/shared/theme/theme_event.dart';
import 'package:mental_health_awareness_chatbot/resources/styles/app_colors.dart';
import 'package:mental_health_awareness_chatbot/utils/routes/route_names.dart';

class NavShellWidget extends StatefulWidget {
  final Widget child;
  final String currentRoute;

  const NavShellWidget({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  @override
  State<NavShellWidget> createState() => _NavShellWidgetState();
}

class _NavShellWidgetState extends State<NavShellWidget> {
  int _selectedIndex = 0;

  static const _routes = [
    RoutesName.homePage,
    RoutesName.chatPage,
    RoutesName.resourcesPage,
    RoutesName.aboutPage,
    RoutesName.contactPage,
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = _routes.indexOf(widget.currentRoute);
    if (_selectedIndex < 0) _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isWide = MediaQuery.of(context).size.width > 800;

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            _buildSideNav(isDark),
            Expanded(child: widget.child),
          ],
        ),
      );
    }

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }

  Widget _buildSideNav(bool isDark) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: _onItemTapped,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
      extended: MediaQuery.of(context).size.width > 1100,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Icon(Icons.spa,
                size: 32,
                color: isDark ? AppColors.primaryLight : AppColors.primary),
            const SizedBox(height: 8),
            if (MediaQuery.of(context).size.width > 1100)
              Text(
                'MindfulChat',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color:
                      isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                ),
              ),
          ],
        ),
      ),
      trailing: Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: IconButton(
              icon: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
              ),
              onPressed: () =>
                  context.read<ThemeBloc>().add(ThemeToggled()),
            ),
          ),
        ),
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.chat_bubble_outline_rounded),
          selectedIcon: Icon(Icons.chat_bubble_rounded),
          label: Text('Chat'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.menu_book_outlined),
          selectedIcon: Icon(Icons.menu_book_rounded),
          label: Text('Resources'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.info_outline_rounded),
          selectedIcon: Icon(Icons.info_rounded),
          label: Text('About'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.support_agent_outlined),
          selectedIcon: Icon(Icons.support_agent_rounded),
          label: Text('Help'),
        ),
      ],
    );
  }

  Widget _buildBottomNav(bool isDark) {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: _onItemTapped,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_bubble_outline_rounded),
          selectedIcon: Icon(Icons.chat_bubble_rounded),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(Icons.menu_book_outlined),
          selectedIcon: Icon(Icons.menu_book_rounded),
          label: 'Resources',
        ),
        NavigationDestination(
          icon: Icon(Icons.info_outline_rounded),
          selectedIcon: Icon(Icons.info_rounded),
          label: 'About',
        ),
        NavigationDestination(
          icon: Icon(Icons.support_agent_outlined),
          selectedIcon: Icon(Icons.support_agent_rounded),
          label: 'Help',
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
    Navigator.pushReplacementNamed(context, _routes[index]);
  }
}
