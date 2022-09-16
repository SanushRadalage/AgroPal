import 'package:agropal/models/feed_item.dart';
import 'package:agropal/providers/pagination_notifer.dart';
import 'package:agropal/repository/post_repository.dart';
import 'package:agropal/services/pagination/pagination.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemsProvider = StateNotifierProvider<PaginationNotifier<FeedItem>,
    PaginationState<FeedItem>>((ref) {
  return PaginationNotifier(
    itemsPerBatch: 20,
    fetchNextItems: (item) {
      return ref.watch(postRepositoryProvider).fetchPosts(item);
    },
  )..init();
});

final postRepositoryProvider =
    Provider<PostRepository>((ref) => PostRepository());
