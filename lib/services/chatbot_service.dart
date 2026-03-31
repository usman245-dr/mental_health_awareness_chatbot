import 'dart:math';

/// Rule-based chatbot service with AI-ready architecture.
/// Provides empathetic, non-diagnostic mental health awareness responses.
class ChatbotService {
  final _random = Random();

  // Crisis keywords that trigger safety response
  static const _crisisKeywords = [
    'suicide',
    'kill myself',
    'end my life',
    'want to die',
    'self-harm',
    'self harm',
    'cutting myself',
    'hurt myself',
    'no reason to live',
    'better off dead',
    'can\'t go on',
    'give up on life',
    'ending it all',
    'not worth living',
  ];

  /// Returns a response and whether it's a crisis response
  ({String response, bool isCrisis}) getResponse(String userMessage) {
    final message = userMessage.toLowerCase().trim();

    // Check for crisis signals first
    if (_containsCrisisSignal(message)) {
      return (response: _getCrisisResponse(), isCrisis: true);
    }

    // Topic-based matching
    if (_matchesAny(message, ['anxiety', 'anxious', 'nervous', 'worried', 'panic', 'fear'])) {
      return (response: _pick(_anxietyResponses), isCrisis: false);
    }

    if (_matchesAny(message, ['depress', 'sad', 'hopeless', 'empty', 'numb', 'unhappy', 'miserable'])) {
      return (response: _pick(_depressionResponses), isCrisis: false);
    }

    if (_matchesAny(message, ['stress', 'overwhelm', 'pressure', 'burnout', 'burnt out', 'overwork'])) {
      return (response: _pick(_stressResponses), isCrisis: false);
    }

    if (_matchesAny(message, ['sleep', 'insomnia', 'tired', 'exhausted', 'fatigue', 'can\'t sleep', 'restless'])) {
      return (response: _pick(_sleepResponses), isCrisis: false);
    }

    if (_matchesAny(message, ['mindful', 'meditat', 'calm', 'peace', 'relax', 'breath'])) {
      return (response: _pick(_mindfulnessResponses), isCrisis: false);
    }

    if (_matchesAny(message, ['self-care', 'self care', 'routine', 'habit', 'wellness', 'well-being'])) {
      return (response: _pick(_selfCareResponses), isCrisis: false);
    }

    if (_matchesAny(message, ['lonely', 'alone', 'isolat', 'no friends', 'nobody cares'])) {
      return (response: _pick(_lonelinessResponses), isCrisis: false);
    }

    if (_matchesAny(message, ['angry', 'anger', 'furious', 'rage', 'frustrated', 'irritat'])) {
      return (response: _pick(_angerResponses), isCrisis: false);
    }

    if (_matchesAny(message, ['thank', 'thanks', 'helpful', 'appreciate'])) {
      return (response: _pick(_gratitudeResponses), isCrisis: false);
    }

    if (_matchesAny(message, ['hello', 'hi', 'hey', 'good morning', 'good evening', 'good afternoon'])) {
      return (response: _pick(_greetingResponses), isCrisis: false);
    }

    if (_matchesAny(message, ['bye', 'goodbye', 'see you', 'take care', 'gotta go'])) {
      return (response: _pick(_farewellResponses), isCrisis: false);
    }

    if (_matchesAny(message, ['help', 'support', 'what can you do', 'how do you work'])) {
      return (response: _pick(_helpResponses), isCrisis: false);
    }

    if (_matchesAny(message, ['affirm', 'positive', 'motivat', 'encourage', 'inspire'])) {
      return (response: _pick(_affirmations), isCrisis: false);
    }

    // Default empathetic response
    return (response: _pick(_defaultResponses), isCrisis: false);
  }

  /// Returns a topic-specific prompt response
  String getTopicResponse(String topic) {
    switch (topic.toLowerCase()) {
      case 'anxiety awareness':
        return _pick(_anxietyResponses);
      case 'depression awareness':
        return _pick(_depressionResponses);
      case 'self-care routines':
        return _pick(_selfCareResponses);
      case 'mindfulness':
        return _pick(_mindfulnessResponses);
      case 'sleep health':
        return _pick(_sleepResponses);
      case 'work stress':
        return _pick(_stressResponses);
      default:
        return _pick(_defaultResponses);
    }
  }

  bool _containsCrisisSignal(String message) {
    return _crisisKeywords.any((keyword) => message.contains(keyword));
  }

  bool _matchesAny(String message, List<String> keywords) {
    return keywords.any((keyword) => message.contains(keyword));
  }

  String _pick(List<String> responses) {
    return responses[_random.nextInt(responses.length)];
  }

  String _getCrisisResponse() {
    return 'I hear you, and I want you to know that your feelings matter deeply. '
        'What you\'re going through sounds really difficult. Please know you\'re not alone.\n\n'
        '🆘 **Please reach out for immediate support:**\n'
        '• **988 Suicide & Crisis Lifeline:** Call or text **988**\n'
        '• **Crisis Text Line:** Text **HOME** to **741741**\n'
        '• **Emergency:** Call **911**\n\n'
        'Talking to a trusted person — a friend, family member, or counselor — '
        'can make a real difference. You deserve support and care. 💙';
  }

  // --- Response pools ---

  static const _greetingResponses = [
    'Hello! Welcome to MindfulChat. 💙 How are you feeling today? I\'m here to listen and support you.',
    'Hi there! It\'s good to have you here. Feel free to share what\'s on your mind, or explore a topic that interests you.',
    'Hey! 😊 I\'m here to chat about mental wellness. How can I support you today?',
  ];

  static const _anxietyResponses = [
    'Anxiety can feel overwhelming, but it\'s more common than you might think. '
        'One helpful technique is the 5-4-3-2-1 grounding method:\n\n'
        '• **5** things you can see\n• **4** things you can touch\n'
        '• **3** things you can hear\n• **2** things you can smell\n'
        '• **1** thing you can taste\n\n'
        'This can help bring you back to the present moment. 💙',
    'It\'s okay to feel anxious — your feelings are valid. '
        'Try taking slow, deep breaths: breathe in for 4 counts, hold for 4, '
        'and exhale for 6. This activates your body\'s calm response.',
    'Anxiety often comes from worrying about the future. When you notice anxious thoughts, '
        'try asking yourself: "What can I actually control right now?" '
        'Focus your energy there, and be gentle with yourself about the rest. 🌿',
  ];

  static const _depressionResponses = [
    'I\'m sorry you\'re feeling this way. It takes courage to express how you feel. '
        'Depression can make everything feel heavy, but please remember — this feeling is temporary, '
        'and support is available. 💙\n\n'
        'Even small steps matter: getting some sunlight, drinking water, or reaching out to someone you trust.',
    'Your feelings are valid, and you don\'t have to face this alone. '
        'When things feel dark, try to focus on just one small thing you can do for yourself today. '
        'It could be as simple as stepping outside for a few minutes. 🌱',
    'I hear you. Depression can make it hard to see light, but it doesn\'t define you. '
        'Speaking with a mental health professional can make a huge difference. '
        'You deserve support and care. Would you like to talk about coping strategies?',
  ];

  static const _stressResponses = [
    'Stress is your body\'s way of responding to demands. Here are some quick stress relievers:\n\n'
        '• **Progressive muscle relaxation** — tense and release each muscle group\n'
        '• **A short walk** — even 10 minutes can shift your mood\n'
        '• **Journaling** — write down what\'s stressing you to externalize it\n'
        '• **Setting boundaries** — it\'s okay to say "no" 💙',
    'Feeling overwhelmed is a sign you may need to pause and recharge. '
        'Try the "brain dump" technique: write everything on your mind onto paper. '
        'This helps clear mental clutter and prioritize what truly needs attention.',
    'Work stress can spill into every area of life. Consider these strategies:\n\n'
        '• Set clear work-life boundaries\n'
        '• Take regular micro-breaks (5 minutes every hour)\n'
        '• Practice saying "no" to non-essential tasks\n'
        '• Talk to your manager if workload is unsustainable\n\n'
        'Your well-being always comes first. 🌿',
  ];

  static const _sleepResponses = [
    'Good sleep is foundational to mental health. Here are evidence-based tips:\n\n'
        '• **Consistent schedule** — same wake time every day, even weekends\n'
        '• **Cool, dark room** — ideal temperature is 65-68°F (18-20°C)\n'
        '• **No screens 1 hour before bed** — blue light disrupts melatonin\n'
        '• **Calming routine** — reading, warm bath, or gentle stretching\n\n'
        'Be patient with yourself — better sleep habits take time to develop. 🌙',
    'Having trouble sleeping can really affect how we feel during the day. '
        'Try a body scan meditation before bed: lie down and slowly bring attention to each part '
        'of your body, releasing tension as you go. It can signal to your brain that it\'s time to rest.',
    'If racing thoughts keep you up, try the "worry journal" technique: '
        'before bed, write down everything on your mind and a small action for each item. '
        'This tells your brain it\'s handled, making it easier to let go. 📝',
  ];

  static const _mindfulnessResponses = [
    'Mindfulness is about being present without judgment. Here\'s a simple exercise:\n\n'
        '1. Sit comfortably and close your eyes\n'
        '2. Focus on your breath — notice each inhale and exhale\n'
        '3. When your mind wanders (it will!), gently guide it back\n'
        '4. Start with just 2-3 minutes and build up\n\n'
        'There\'s no "wrong" way to be mindful. The practice is in the returning. 🧘',
    'Let\'s try a quick breathing exercise together:\n\n'
        '🌊 **Box Breathing:**\n'
        '• Breathe in for **4 seconds**\n'
        '• Hold for **4 seconds**\n'
        '• Breathe out for **4 seconds**\n'
        '• Hold for **4 seconds**\n\n'
        'Repeat 4 times. This technique is used by navy SEALs to stay calm under pressure!',
    'Mindfulness doesn\'t mean emptying your mind — it means noticing thoughts without getting caught up in them. '
        'Think of thoughts like clouds passing through the sky. You can observe them, '
        'acknowledge them, and let them float by. 🌤️',
  ];

  static const _selfCareResponses = [
    'Self-care isn\'t selfish — it\'s essential! Here\'s a simple daily wellness checklist:\n\n'
        '✅ Drink enough water\n'
        '✅ Move your body (even a short walk)\n'
        '✅ Eat a nourishing meal\n'
        '✅ Connect with someone you care about\n'
        '✅ Do one thing just for enjoyment\n'
        '✅ Get enough rest\n\n'
        'You don\'t need to be perfect — just intentional. 🌸',
    'Some self-care ideas that don\'t cost a thing:\n\n'
        '• Take a mindful walk in nature\n'
        '• Write 3 things you\'re grateful for\n'
        '• Listen to music that uplifts you\n'
        '• Spend time with a pet or loved one\n'
        '• Unplug from social media for an hour\n'
        '• Take a warm shower and be present with the sensations\n\n'
        'What sounds appealing to you? 💛',
    'Building a self-care routine starts small. Pick ONE thing you can do daily '
        'that nourishes your mind, body, or spirit. Consistency matters more than intensity. '
        'What\'s one small act of kindness you can offer yourself today? 🌿',
  ];

  static const _lonelinessResponses = [
    'Feeling lonely can be really painful, and it\'s more common than you\'d think. '
        'You\'re not alone in feeling alone. 💙\n\n'
        'Some gentle steps forward:\n'
        '• Reach out to one person — even a simple text counts\n'
        '• Join an online community around an interest\n'
        '• Volunteer — helping others creates connection\n'
        '• Be kind to yourself about needing connection — it\'s human',
    'Loneliness doesn\'t mean something is wrong with you. Humans are wired for connection. '
        'Even small interactions — a chat with a neighbor, joining a group activity — can help bridge the gap. '
        'What\'s one small social step you might take this week?',
  ];

  static const _angerResponses = [
    'Anger is a natural emotion — it often signals that something important to you '
        'feels threatened or unfair. Here are healthy ways to process it:\n\n'
        '• **Pause** — count to 10 before responding\n'
        '• **Move** — physical activity helps release tension\n'
        '• **Express** — write about it or talk to someone you trust\n'
        '• **Breathe** — slow breathing calms your nervous system\n\n'
        'It\'s okay to feel angry. What matters is how you channel it. 🔥',
    'When anger arises, try the STOP technique:\n\n'
        '**S** — Stop what you\'re doing\n'
        '**T** — Take a breath\n'
        '**O** — Observe what you\'re feeling\n'
        '**P** — Proceed with awareness\n\n'
        'This small pause can make a big difference in your response.',
  ];

  static const _gratitudeResponses = [
    'You\'re welcome! I\'m glad I could help. Remember, taking time to care for your mental health is a strength. Keep being kind to yourself! 💙',
    'I appreciate you sharing that! Practicing gratitude is actually a powerful mental health tool. Thank you for having this conversation with me. 🌟',
    'That means a lot! Remember, I\'m always here whenever you want to talk. You\'re doing great by prioritizing your well-being. 😊',
  ];

  static const _farewellResponses = [
    'Take care of yourself! Remember, it\'s okay to come back whenever you need support. You\'re doing great. 💙',
    'Goodbye for now! I hope you carry a little warmth from our conversation. Be gentle with yourself today. 🌸',
    'See you next time! Here\'s a parting thought: you are worthy of rest, joy, and support. Take care! 😊',
  ];

  static const _helpResponses = [
    'I\'m here to support your mental wellness! Here\'s what I can help with:\n\n'
        '• 💬 **Emotional support** — share how you\'re feeling\n'
        '• 🧠 **Mental health awareness** — learn about anxiety, depression, stress\n'
        '• 🧘 **Mindfulness & breathing** — guided exercises\n'
        '• 💤 **Sleep health** — tips for better rest\n'
        '• 🌿 **Self-care** — daily wellness ideas\n'
        '• ✨ **Positive affirmations** — uplifting messages\n\n'
        'What would you like to explore?',
  ];

  static const _affirmations = [
    '✨ **You are enough, just as you are.** Your worth isn\'t measured by productivity or perfection.',
    '✨ **It\'s okay to not be okay.** Healing isn\'t linear, and every step counts.',
    '✨ **You are resilient.** Look how far you\'ve already come through difficult times.',
    '✨ **Your feelings are valid.** You don\'t need permission to feel what you feel.',
    '✨ **You deserve kindness** — especially from yourself.',
    '✨ **Taking rest is not giving up.** It\'s how you recharge to keep going.',
    '✨ **You are not a burden.** The people who love you want to be there for you.',
  ];

  static const _defaultResponses = [
    'Thank you for sharing that with me. I\'m here to listen. '
        'Would you like to explore any specific mental health topic together? 💙',
    'I appreciate you opening up. Mental wellness is a journey, and every conversation matters. '
        'Is there something specific on your mind today?',
    'I hear you. Whatever you\'re going through, you don\'t have to face it alone. '
        'Feel free to ask me about stress management, mindfulness, self-care, or any other topic. 🌿',
    'That\'s an interesting thought. Would you like to talk more about how you\'re feeling, '
        'or would you prefer some wellness tips or a breathing exercise?',
  ];
}
