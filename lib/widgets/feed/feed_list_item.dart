import 'package:agropal/models/feed_item.dart';
import 'package:agropal/providers/auth_notifier.dart';
import 'package:agropal/theme/colors.dart';
import 'package:agropal/utils/date_utils.dart';
import 'package:agropal/widgets/feed/feed_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedListItem extends ConsumerWidget {
  const FeedListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final FeedItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authenticationProvider = ref.watch(authenticationProvider);
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed('/detailView', arguments: item),
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  image(
                    item.cropType,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            landSize(
                                context,
                                item.landSize,
                                item.measureUnit,
                                const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            PopupMenuButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: AppColors.iconColor,
                              ),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                PopupMenuItem(
                                  child: Visibility(
                                    replacement: const ListTile(
                                      leading: Icon(Icons.report),
                                      title: Text('Report'),
                                    ),
                                    visible: item.userId ==
                                        _authenticationProvider.getUserId(),
                                    child: ListTile(
                                      leading: const Icon(Icons.delete),
                                      title: const Text('Delete'),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        showDialog(
                                            context: context,
                                            builder: ((context) =>
                                                feedOptionDialog(
                                                    context, ref, item.id)));
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        item.isOrganic
                            ? Text(
                                "Organic",
                                style: TextStyle(
                                    fontSize: 16, color: AppColors.primary),
                              )
                            : Text("Inorganic",
                                style: TextStyle(
                                    fontSize: 16, color: AppColors.error)),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            const Text("Funding Status ",
                                style: TextStyle(fontSize: 16)),
                            item.withFund
                                ? Icon(
                                    Icons.check_circle,
                                    color: AppColors.primary,
                                    size: 17,
                                  )
                                : Icon(
                                    Icons.cancel_rounded,
                                    color: AppColors.error,
                                    size: 17,
                                  )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text(formatTimestamp(item.createdAt))],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget landSize(BuildContext context, String size, String measureUnit,
    TextStyle? textStyle) {
  if (measureUnit == 'acre') {
    return Text('$size ${AppLocalizations.of(context)!.acre}',
        style: textStyle);
  } else {
    return Text('$size ${AppLocalizations.of(context)!.perch}',
        style: textStyle);
  }
}

Widget image(String cropType) {
  if (cropType == "Vegitables") {
    return Image.asset(
      'assets/images/vegetable.png',
      width: 70,
      height: 70,
    );
  } else if (cropType == "fruits") {
    return Image.asset(
      'assets/images/fruits.png',
      width: 70,
      height: 70,
    );
  } else if (cropType == "Rice") {
    return Image.asset(
      'assets/images/rice.png',
      width: 70,
      height: 70,
    );
  } else if (cropType == "Herbs/Spices") {
    return Image.asset(
      'assets/images/herbs.png',
      width: 70,
      height: 70,
    );
  } else if (cropType == "Flowers") {
    return Image.asset(
      'assets/images/sunflower.png',
      width: 70,
      height: 70,
    );
  } else {
    return Image.asset(
      'assets/images/sprout.png',
      width: 70,
      height: 70,
    );
  }
}
