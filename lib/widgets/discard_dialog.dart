import 'package:agropal/providers/button_notifier.dart';
import 'package:agropal/providers/create_post_notifier.dart';
import 'package:agropal/providers/file_provider.dart';
import 'package:agropal/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

AlertDialog discardDialog(BuildContext context, WidgetRef ref) {
  return AlertDialog(
    title: const Text('Discard Post'),
    content: const Text('This will discard your post without creatingS.'),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          ref.watch(createPostModelProvider).resetModel();
          ref.watch(fileProvider).resetFiles();
          ref.watch(toggleButtonProvider).resetButtons();
          Navigator.pop(context);
          Navigator.popAndPushNamed(context, '/home');
        },
        child: Text(
          'Discard',
          style: TextStyle(color: AppColors.error),
        ),
      ),
    ],
  );
}
