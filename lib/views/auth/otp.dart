import 'package:agropal/providers/auth_notifier.dart';
import 'package:agropal/theme/colors.dart';
import 'package:agropal/theme/themes.dart';
import 'package:agropal/widgets/buttons.dart';
import 'package:agropal/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/app_bar.dart';

class OtpVerifier extends ConsumerWidget {
  const OtpVerifier({Key? key}) : super(key: key);

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
                AppLocalizations.of(context)!.otpTitle,
                style: getAppTheme().textTheme.headline2,
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  PinCodeTextField(
                    // controller: otpController,
                    appContext: context,
                    length: 6,
                    onChanged: (otp) {
                      ref.watch(loginModelProvider).updateOtp(otp);
                    },
                    // onCompleted: (otp) => _verifyOtp(context, model, otp),
                    pinTheme: PinTheme(
                        activeColor: AppColors.primary,
                        selectedColor: AppColors.primary,
                        inactiveColor: Colors.grey,
                        disabledColor: Colors.grey,
                        // activeFillColor: Colors.green,
                        // selectedFillColor: Colors.blue,
                        // inactiveFillColor: Colors.blue,
                        shape: PinCodeFieldShape.box,
                        borderWidth: 1,
                        borderRadius: BorderRadius.circular(6)),
                    showCursor: false,
                    keyboardType: TextInputType.number,
                    enablePinAutofill: true,
                    autoFocus: true,
                  ),
                  MainElevatedButton(
                      onPressed: () {
                        ref.watch(authenticationProvider).verifyOtp(
                            context, ref.watch(loginModelProvider).otp!, () {
                          Navigator.of(context).popAndPushNamed('/home');
                        }, () {
                          snackBar(AppLocalizations.of(context)!
                              .invalidMobileNumber);
                        });
                      },
                      child: Text(AppLocalizations.of(context)!.done)),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
