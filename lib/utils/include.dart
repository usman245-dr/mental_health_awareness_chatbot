// Barrel file — single import for all common utilities, styles, and widgets

// Resources
export 'package:mental_health_awareness_chatbot/resources/styles/app_colors.dart';
export 'package:mental_health_awareness_chatbot/resources/styles/app_styles.dart';
export 'package:mental_health_awareness_chatbot/resources/styles/app_theme.dart';

// Utils
export 'package:mental_health_awareness_chatbot/utils/constants.dart';
export 'package:mental_health_awareness_chatbot/utils/routes/route_names.dart';
export 'package:mental_health_awareness_chatbot/utils/routes/app_router.dart';

// Models
export 'package:mental_health_awareness_chatbot/model/message.dart';

// Services
export 'package:mental_health_awareness_chatbot/services/chatbot_service.dart';

// Repository
export 'package:mental_health_awareness_chatbot/repository/chat_repository.dart';

// BLoC
export 'package:mental_health_awareness_chatbot/bloc/chat/chat_bloc.dart';
export 'package:mental_health_awareness_chatbot/bloc/chat/chat_event.dart';
export 'package:mental_health_awareness_chatbot/bloc/chat/chat_state.dart';
export 'package:mental_health_awareness_chatbot/bloc/shared/theme/theme_bloc.dart';
export 'package:mental_health_awareness_chatbot/bloc/shared/theme/theme_event.dart';
export 'package:mental_health_awareness_chatbot/bloc/shared/theme/theme_state.dart';

// Shared Widgets
export 'package:mental_health_awareness_chatbot/ui/widgets/app_bar_widget.dart';
export 'package:mental_health_awareness_chatbot/ui/widgets/glass_card_widget.dart';
export 'package:mental_health_awareness_chatbot/ui/widgets/chat_bubble_widget.dart';
export 'package:mental_health_awareness_chatbot/ui/widgets/typing_indicator_widget.dart';
export 'package:mental_health_awareness_chatbot/ui/widgets/topic_card_widget.dart';
export 'package:mental_health_awareness_chatbot/ui/widgets/nav_shell_widget.dart';
