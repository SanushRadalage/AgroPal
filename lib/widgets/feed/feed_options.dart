import 'package:agropal/providers/feed_item_provider.dart';
import 'package:agropal/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget feedOptionDialog(BuildContext context, WidgetRef ref, String postId) {
  return AlertDialog(
    title: const Text('Delete Post'),
    content: const Text('This will delete your post from the app.'),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          ref.watch(postRepositoryProvider).deletePost(postId);
          Navigator.pop(context);
        },
        child: Text(
          'Delete',
          style: TextStyle(color: AppColors.error),
        ),
      ),
    ],
  );
}
