import 'package:agropal/repository/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatProvider = Provider<ChatRepository>((ref) => ChatRepository());
