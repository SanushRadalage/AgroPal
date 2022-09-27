import 'package:agropal/providers/settings_notifier.dart';
import 'package:agropal/routes/routes.dart';
import 'package:agropal/theme/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(settingsProvider).getLocalePref(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Locale(snapshot.data ?? 'en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          title: "AgroPal",
          theme: getAppTheme(),
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
