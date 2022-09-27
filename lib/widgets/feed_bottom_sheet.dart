import 'package:agropal/providers/feed_item_provider.dart';
import 'package:agropal/theme/colors.dart';
import 'package:agropal/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainBottomSheet extends ConsumerWidget {
  const MainBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> districts = [
      "All",
      AppLocalizations.of(context)!.colombo,
      AppLocalizations.of(context)!.gampaha,
      AppLocalizations.of(context)!.kalutara,
      AppLocalizations.of(context)!.kandy,
      AppLocalizations.of(context)!.matale,
      AppLocalizations.of(context)!.nuwaraeliya,
      AppLocalizations.of(context)!.galle,
      AppLocalizations.of(context)!.matara,
      AppLocalizations.of(context)!.hambantota,
      AppLocalizations.of(context)!.jaffna,
      AppLocalizations.of(context)!.kilinochchi,
      AppLocalizations.of(context)!.mannar,
      AppLocalizations.of(context)!.vavunia,
      AppLocalizations.of(context)!.mullaitivy,
      AppLocalizations.of(context)!.batticaloa,
      AppLocalizations.of(context)!.ampara,
      AppLocalizations.of(context)!.trincomalee,
      AppLocalizations.of(context)!.trincomalee,
      AppLocalizations.of(context)!.puttalam,
      AppLocalizations.of(context)!.anuradhapura,
      AppLocalizations.of(context)!.polonnaruwa,
      AppLocalizations.of(context)!.badulla,
      AppLocalizations.of(context)!.moneragala,
      AppLocalizations.of(context)!.ratnapura,
      AppLocalizations.of(context)!.kegalle,
    ];
    final List<String> cropTypes = [
      "All",
      AppLocalizations.of(context)!.vegitables,
      AppLocalizations.of(context)!.fruits,
      AppLocalizations.of(context)!.rice,
      AppLocalizations.of(context)!.herbs,
      AppLocalizations.of(context)!.flowers,
      AppLocalizations.of(context)!.other,
    ];

    final List<String> fundingTypes = [
      "Both",
      "With Funding",
      "Without Funding"
    ];

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                label: Text(AppLocalizations.of(context)!.district),
                labelStyle: TextStyle(color: AppColors.primary),
                border: const OutlineInputBorder(
                    gapPadding: 2, borderSide: BorderSide(width: 0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary)),
              ),
              onChanged: (String? value) {
                if (value != null) {
                  ref.watch(sortOptionProvider).updateDistrict(district: value);
                }
              },
              value: districts[0],
              items: districts.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                label: Text(AppLocalizations.of(context)!.cropType),
                labelStyle: TextStyle(color: AppColors.primary),
                border: const OutlineInputBorder(
                    gapPadding: 2, borderSide: BorderSide(width: 0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary)),
              ),
              onChanged: (String? value) {
                if (value != null) {
                  ref.watch(sortOptionProvider).updateCropType(cropType: value);
                }
              },
              value: cropTypes[0],
              items: cropTypes.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                label: Text(AppLocalizations.of(context)!.investmentStatus),
                labelStyle: TextStyle(color: AppColors.primary),
                border: const OutlineInputBorder(
                    gapPadding: 2, borderSide: BorderSide(width: 0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary)),
              ),
              onChanged: (String? value) {
                if (value != null) {
                  if (value == "All") {
                    ref
                        .watch(sortOptionProvider)
                        .updateFundStatus(fundStatus: 0);
                  } else if (value == "With Funding") {
                    ref
                        .watch(sortOptionProvider)
                        .updateFundStatus(fundStatus: 1);
                  } else {
                    ref
                        .watch(sortOptionProvider)
                        .updateFundStatus(fundStatus: 2);
                  }
                }
              },
              value: fundingTypes[0],
              items: fundingTypes.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            MainElevatedButton(
                onPressed: () {
                  // ref.watch(postRepositoryProvider).streamFeedItems(
                  //     ref.watch(sortOptionProvider).cropType,
                  //     ref.watch(sortOptionProvider).district,
                  //     ref.watch(sortOptionProvider).fundStatus);
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context)!.done)),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
