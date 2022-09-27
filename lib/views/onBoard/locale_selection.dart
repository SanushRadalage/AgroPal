import 'package:agropal/models/language_item_model.dart';
import 'package:agropal/providers/settings_notifier.dart';
import 'package:agropal/theme/colors.dart';
import 'package:agropal/theme/themes.dart';
import 'package:agropal/widgets/app_bar.dart';
import 'package:agropal/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleSelection extends StatelessWidget {
  final languages = [
    LanguageItem(
      key: 'en',
      value: 'English',
    ),
    LanguageItem(
      key: 'si',
      value: 'සිංහල',
    ),
    LanguageItem(
      key: 'ta',
      value: 'தமிழ்',
    ),
  ];

  LocaleSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LanguageItem languageSelection = languages.first;

    return Scaffold(
      appBar: const MainAppBar(isLeading: false),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/images/translate.png',
                width: 80,
                height: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.localeTitle,
                style: getAppTheme().textTheme.headline2,
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          gapPadding: 2, borderSide: BorderSide(width: 0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primary)),
                    ),
                    onChanged: (LanguageItem? value) {
                      if (value != null) languageSelection = value;
                    },
                    onSaved: (LanguageItem? value) {},
                    value: languageSelection,
                    items: languages.map<DropdownMenuItem<LanguageItem>>(
                        (LanguageItem item) {
                      return DropdownMenuItem<LanguageItem>(
                        value: item,
                        child: Text(item.value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return MainElevatedButton(
                          onPressed: () {
                            ref
                                .read(settingsProvider)
                                .setLocalePref(languageSelection.key);
                            Navigator.of(context).popAndPushNamed('/login');
                          },
                          child: Text(AppLocalizations.of(context)!.next));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
