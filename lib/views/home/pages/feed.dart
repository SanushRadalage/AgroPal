import 'package:agropal/providers/feed_item_provider.dart';
import 'package:agropal/widgets/feed/item_list.dart';
import 'package:agropal/widgets/feed/ongoing_bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Feed extends ConsumerWidget {
  Feed({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.width * 0.20;
      if (maxScroll - currentScroll <= delta) {
        ref.read(itemsProvider.notifier).fetchNextBatch();
      }
    });
    return CustomScrollView(
      controller: scrollController,
      slivers: const [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 12,
          ),
        ),
        ItemsList(),
        OnGoingBottomWidget(),
      ],
    );
  }
}
