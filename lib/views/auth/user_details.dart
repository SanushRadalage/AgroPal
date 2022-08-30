import 'package:agropal/providers/auth_notifier.dart';
import 'package:agropal/providers/signup_notifier.dart';
import 'package:agropal/theme/colors.dart';
import 'package:agropal/widgets/app_bar.dart';
import 'package:agropal/widgets/buttons.dart';
import 'package:agropal/widgets/custom_text_field.dart';
import 'package:agropal/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserDetails extends StatelessWidget {
  UserDetails({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final userTypes = ["Landowner", "Farmer"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          isLeading: false,
        ),
        body: SafeArea(
            child: Column(
          children: [
            Consumer(
              key: key,
              builder: (context, ref, child) {
                return Container(
                  margin: const EdgeInsets.all(16),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                              labelText:
                                  AppLocalizations.of(context)!.firstName,
                              onSaved: (String? value) {
                                ref
                                    .watch(signupModelProvider)
                                    .updateModel(firstName: value);
                              },
                              validationMessage: AppLocalizations.of(context)!
                                  .validationFName),
                          CustomTextField(
                              labelText: AppLocalizations.of(context)!.lastName,
                              onSaved: (String? value) {
                                ref
                                    .watch(signupModelProvider)
                                    .updateModel(lastName: value);
                              },
                              validationMessage: AppLocalizations.of(context)!
                                  .validationLName),
                          CustomTextField(
                              labelText: AppLocalizations.of(context)!.nic,
                              onSaved: (String? value) {
                                ref
                                    .watch(signupModelProvider)
                                    .updateModel(nic: value);
                              },
                              maxLength: 20,
                              validationMessage:
                                  AppLocalizations.of(context)!.validationNIC),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.primary)),
                                border: const OutlineInputBorder(
                                    gapPadding: 2,
                                    borderSide: BorderSide(width: 0))),
                            onChanged: (String? value) {
                              ref
                                  .watch(signupModelProvider)
                                  .updateModel(type: value);
                            },
                            value: userTypes[0],
                            items: userTypes
                                .map<DropdownMenuItem<String>>((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          MainElevatedButton(
                              onPressed: () {
                                final state = _formKey.currentState;
                                if (state != null && state.validate()) {
                                  state.save();

                                  final signUpModel = ref
                                      .watch(signupModelProvider)
                                      .signupModel;
                                  ref
                                      .watch(authenticationProvider)
                                      .updateUser(context, signUpModel);
                                }
                              },
                              child: Text(AppLocalizations.of(context)!.done)),
                        ],
                      )),
                );
              },
            )
          ],
        )));
  }
}
