import 'package:agropal/models/feed_item.dart';
import 'package:agropal/models/user.dart';
import 'package:agropal/providers/auth_notifier.dart';
import 'package:agropal/theme/colors.dart';
import 'package:agropal/widgets/app_bar.dart';
import 'package:agropal/widgets/feed/feed_list_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailView extends StatelessWidget {
  const DetailView({Key? key, required this.feedItem}) : super(key: key);

  final FeedItem feedItem;

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    final maxWight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const MainAppBar(
        isLeading: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                feedItem.images.isNotEmpty
                    ? Expanded(
                        child: CarouselSlider(
                          options: CarouselOptions(
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false),
                          items: feedItem.images.map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: FadeInImage.assetNetwork(
                                width: maxWight,
                                height: maxHeight * 0.25,
                                fit: BoxFit.fill,
                                placeholderFit: BoxFit.cover,
                                placeholder: 'assets/images/placeholder.png',
                                image: item,
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0XFF9ba4b4),
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.0),
                            ),
                          ),
                          margin: const EdgeInsets.all(8),
                          width: maxWight * 0.3,
                          height: maxHeight * 0.20,
                          child: const Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                      )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16, right: 16, left: 16),
              child: Text(
                "Land Details",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 8, left: 16, right: 16, bottom: 16),
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.background,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.borderColor,
                    offset: const Offset(1, 1), //(x,y)
                    blurRadius: 5.0,
                  ),
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(6.0),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.district),
                        Text(feedItem.district)
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.borderColor,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.landSize),
                        landSize(context, feedItem.landSize,
                            feedItem.measureUnit, null),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.borderColor,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.cropType),
                        Text(feedItem.cropType)
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.borderColor,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.machinery),
                        Text(feedItem.withEquipment ? "Yes" : "No")
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.borderColor,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.organic),
                        Text(feedItem.isOrganic ? "Yes" : "No")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, right: 16, left: 16),
              child: Text(
                "Funding Details",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 8, left: 16, right: 16, bottom: 16),
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.background,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.borderColor,
                    offset: const Offset(1, 1), //(x,y)
                    blurRadius: 5.0,
                  ),
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(6.0),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.investOnFarming),
                        Text(feedItem.withFund ? "Yes" : "No")
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.borderColor,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.lawyerFee),
                        Text(feedItem.leagalFund)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: AppColors.background,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 8, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: feedItem.avatar != null
                              ? NetworkImage(feedItem.avatar!)
                              : const NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/agropal-532e9.appspot.com/o/user.png?alt=media&token=3711fab4-1f20-4c33-a562-a382c94acdec"),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          feedItem.userName,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return Visibility(
                        visible: feedItem.userId !=
                            ref.read(authenticationProvider).getUserId(),
                        child: IconButton(
                            color: AppColors.secondary,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/chat',
                                  arguments: User(
                                      id: feedItem.userId,
                                      avatar: feedItem.avatar,
                                      name: feedItem.userName));
                            },
                            icon: const Icon(
                              Icons.message,
                              size: 30,
                            )),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
