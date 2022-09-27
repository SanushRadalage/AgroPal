import 'dart:developer';

import 'package:agropal/models/feed_item.dart';
import 'package:agropal/providers/feed_item_provider.dart';
import 'package:agropal/widgets/app_bar.dart';
import 'package:agropal/widgets/feed/feed_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class UserPosts extends ConsumerWidget {
  const UserPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MainAppBar(
        isLeading: true,
      ),
      body: StreamBuilder<Iterable<FeedItem>>(
          stream: ref.watch(postRepositoryProvider).streamUserPosts(),
          builder: ((context, snapshot) {
            final list = snapshot.data?.toList() ?? [];

            if (snapshot.hasError) {
              log(snapshot.error.toString());
              return Center(
                  child: Lottie.asset(
                'assets/lotties/error.json',
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ));
            } else {
              if (list.isNotEmpty) {
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return FeedListItem(item: list[index]);
                  },
                );
              } else {
                return Center(
                    child: Lottie.asset(
                  'assets/lotties/empty.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ));
              }
            }
          })),
    );
  }
}
