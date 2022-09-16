import 'package:agropal/models/feed_item.dart';
import 'package:agropal/theme/colors.dart';
import 'package:agropal/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemsListBuilder extends StatelessWidget {
  const ItemsListBuilder({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<FeedItem> items;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return InkWell(
            onTap: () => Navigator.of(context).pushNamed('/detailView'),
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
                          items[index].cropType,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              landSize(context, items[index].landSize,
                                  items[index].measureUnit),
                              const SizedBox(
                                height: 4,
                              ),
                              items[index].isOrganic
                                  ? Text(
                                      "Organic",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.primary),
                                    )
                                  : Text("Inorganic",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.error)),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  const Text("Funding Status ",
                                      style: TextStyle(fontSize: 16)),
                                  items[index].withFund
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
                      children: [Text(formatTimestamp(items[index].createdAt))],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }
}

Widget landSize(BuildContext context, String size, String measureUnit) {
  if (measureUnit == 'acre') {
    return Text('$size ${AppLocalizations.of(context)!.acre}',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  } else {
    return Text('$size ${AppLocalizations.of(context)!.perch}',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
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
