import 'package:agropal/providers/auth_notifier.dart';
import 'package:agropal/providers/time_notifier.dart';
import 'package:agropal/widgets/headline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Splash extends ConsumerWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authStateProvider).when(
        data: (data) {
          if (data != null) {
            ref.read(timerProvider).delayOnNavigate(context, 5, "/home");
          } else {
            ref
                .read(timerProvider)
                .delayOnNavigate(context, 5, "/localeSelection");
          }
        },
        loading: () => {},
        error: (e, trace) => {});
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover),
          ),
          // padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 40.h),
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Headline(
                  size: 40,
                )),
          ),
        ),
      ),
    );
  }
}
