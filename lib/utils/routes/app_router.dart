import 'package:flutter/material.dart';
import 'package:mental_health_awareness_chatbot/ui/pages/about_page.dart';
import 'package:mental_health_awareness_chatbot/ui/pages/chat_page.dart';
import 'package:mental_health_awareness_chatbot/ui/pages/contact_page.dart';
import 'package:mental_health_awareness_chatbot/ui/pages/home_page.dart';
import 'package:mental_health_awareness_chatbot/ui/pages/resources_page.dart';
import 'package:mental_health_awareness_chatbot/utils/routes/route_names.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homePage:
        return _buildRoute(const HomePage());
      case RoutesName.chatPage:
        return _buildRoute(const ChatPage());
      case RoutesName.resourcesPage:
        return _buildRoute(const ResourcesPage());
      case RoutesName.aboutPage:
        return _buildRoute(const AboutPage());
      case RoutesName.contactPage:
        return _buildRoute(const ContactPage());
      default:
        return _buildRoute(const HomePage());
    }
  }

  static PageRouteBuilder _buildRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
