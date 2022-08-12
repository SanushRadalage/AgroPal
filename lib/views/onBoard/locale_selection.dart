import 'package:agropal/models/language_item_model.dart';
import 'package:agropal/providers/locale_notifier.dart';
import 'package:agropal/theme/themes.dart';
import 'package:agropal/widgets/headline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/buttons.dart';

class LocaleSelection extends ConsumerWidget {
  const LocaleSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    LanguageItem languageSelection =
        languages.firstWhere((item) => 'en' == item.key);

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Headline(),
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
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.language,
                        size: 20,
                      ),
                    ),
                    onChanged: (LanguageItem? value) {},
                    onSaved: (LanguageItem? value) {
                      if (value != null) languageSelection = value;
                    },
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
                  MainElevatedButton(
                      onPressed: () {
                        ref
                            .watch(localeProvider)
                            .setLocale(Locale(languageSelection.key));
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: Text(AppLocalizations.of(context)!.next)),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
