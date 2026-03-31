import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_awareness_chatbot/utils/include.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        chatRepository: context.read<ChatRepository>(),
      )..add(ChatStarted()),
      child: NavShellWidget(
        currentRoute: RoutesName.chatPage,
        child: const _ChatPageContent(),
      ),
    );
  }
}

class _ChatPageContent extends StatefulWidget {
  const _ChatPageContent();

  @override
  State<_ChatPageContent> createState() => _ChatPageContentState();
}

class _ChatPageContentState extends State<_ChatPageContent> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    context.read<ChatBloc>().add(ChatSendMessage(text));
    _messageController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Chat',
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
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is ChatLoaded) _scrollToBottom();
              },
              builder: (context, state) {
                if (state is ChatLoaded) {
                  return _buildChatList(state, isDark);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          // Input bar
          _buildInputBar(isDark),
        ],
      ),
    );
  }

  Widget _buildChatList(ChatLoaded state, bool isDark) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      itemCount: state.messages.length +
          (state.isTyping ? 1 : 0) +
          (state.messages.length == 1 ? 1 : 0), // topic suggestions
      itemBuilder: (context, index) {
        // Topic suggestions after welcome message
        if (state.messages.length == 1 && index == 1) {
          return _buildTopicSuggestions(isDark);
        }

        // Adjust index for topic suggestions row
        final messageIndex =
            (state.messages.length == 1 && index > 1) ? index - 1 : index;

        if (messageIndex >= state.messages.length) {
          if (state.isTyping) {
            return const TypingIndicatorWidget();
          }
          return const SizedBox.shrink();
        }

        return _MessageEntry(message: state.messages[messageIndex]);
      },
    );
  }

  Widget _buildTopicSuggestions(bool isDark) {
    const topics = [
      ('Anxiety awareness', '😰'),
      ('Depression awareness', '💭'),
      ('Self-care routines', '🌸'),
      ('Mindfulness', '🧘'),
      ('Sleep health', '🌙'),
      ('Work stress', '💼'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 40),
            child: Text(
              'Suggested topics:',
              style: AppStyles.bodySmall.copyWith(
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: topics.map((t) {
                return TopicCardWidget(
                  title: t.$1,
                  emoji: t.$2,
                  onTap: () =>
                      context.read<ChatBloc>().add(ChatSelectTopic(t.$1)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.border,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                focusNode: _focusNode,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                maxLines: 3,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  filled: true,
                  fillColor:
                      isDark ? AppColors.darkCard : AppColors.cardBackground,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: isDark
                          ? AppColors.primaryLight
                          : AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Material(
              color: isDark ? AppColors.primaryLight : AppColors.primary,
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                onTap: _sendMessage,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: const Icon(
                    Icons.send_rounded,
                    color: AppColors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageEntry extends StatefulWidget {
  final Message message;

  const _MessageEntry({required this.message});

  @override
  State<_MessageEntry> createState() => _MessageEntryState();
}

class _MessageEntryState extends State<_MessageEntry>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ChatBubbleWidget(message: widget.message),
      ),
    );
  }
}
