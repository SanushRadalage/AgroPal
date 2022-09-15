import 'package:agropal/providers/auth_notifier.dart';
import 'package:agropal/theme/colors.dart';
import 'package:agropal/theme/themes.dart';
import 'package:agropal/widgets/app_bar.dart';
import 'package:agropal/widgets/buttons.dart';
import 'package:agropal/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Login extends ConsumerWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: MainAppBar(isLeading: false),
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
                  'assets/images/phone.png',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.loginTitle,
                  style: getAppTheme().textTheme.headline2,
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    IntlPhoneField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 0),
                        ),
                        labelText: AppLocalizations.of(context)!.mobileNumber,
                      ),
                      initialCountryCode: "LK",
                      autoValidate: true,
                      validator: (input) {
                        // if (input == null || input.isEmpty) {
                        //   return AppLocalizations.of(context)!
                        //       .phoneValidation;
                        // }
                        return null;
                      },
                      onChanged: (value) {
                        ref.watch(loginModelProvider).updateModel(
                            countryCode: value.countryCode,
                            phoneNumber: value.number);
                      },
                    ),
                    MainElevatedButton(
                        onPressed: () {
                          ref.watch(authenticationProvider).signInWithPhone(
                              context, ref.watch(loginModelProvider).loginModel,
                              () {
                            ref.watch(authStateProvider).when(
                                data: (data) {
                                  if (data != null) {
                                    if (data.displayName == null) {
                                      Navigator.of(context)
                                          .popAndPushNamed('/userDetails');
                                    } else {
                                      Navigator.of(context)
                                          .popAndPushNamed('/home');
                                    }
                                  }
                                },
                                error:
                                    (Object error, StackTrace? stackTrace) {},
                                loading: () {});
                          }, () {
                            snackBar(AppLocalizations.of(context)!
                                .invalidMobileNumber);
                          }, () {
                            Navigator.of(context).pushNamed('/otp');
                          });
                        },
                        child: Text(AppLocalizations.of(context)!.next)),
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
