import 'package:agropal/providers/button_notifier.dart';
import 'package:agropal/providers/create_post_notifier.dart';
import 'package:agropal/theme/colors.dart';
import 'package:agropal/widgets/app_bar.dart';
import 'package:agropal/widgets/buttons.dart';
import 'package:agropal/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreatePost extends StatelessWidget {
  CreatePost({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final List<Widget> sizes = <Widget>[
      Text(AppLocalizations.of(context)!.acre),
      Text(AppLocalizations.of(context)!.perch),
    ];
    final List<Widget> investType = <Widget>[
      Text(AppLocalizations.of(context)!.yes),
      Text(AppLocalizations.of(context)!.no),
    ];
    final List<Widget> machineryStatus = <Widget>[
      Text(AppLocalizations.of(context)!.yes),
      Text(AppLocalizations.of(context)!.no),
    ];
    final List<String> districts = [
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
      AppLocalizations.of(context)!.vegitables,
      AppLocalizations.of(context)!.fruits,
      AppLocalizations.of(context)!.rice,
      AppLocalizations.of(context)!.herbs,
      AppLocalizations.of(context)!.flowers,
      AppLocalizations.of(context)!.other,
    ];
    final List<Widget> organicStatus = <Widget>[
      Text(AppLocalizations.of(context)!.yes),
      Text(AppLocalizations.of(context)!.no),
    ];
    final List<Widget> lawyerFeeStatus = <Widget>[
      const Text("0%"),
      const Text("50%"),
      const Text("100%"),
    ];
    return Scaffold(
      appBar: MainAppBar(isLeading: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(16),
              child: Consumer(
                  key: key,
                  builder: (context, ref, child) {
                    return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                label: Text(
                                    AppLocalizations.of(context)!.district),
                                labelStyle: TextStyle(color: AppColors.primary),
                                border: const OutlineInputBorder(
                                    gapPadding: 2,
                                    borderSide: BorderSide(width: 0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.primary)),
                              ),
                              onChanged: (String? value) {
                                if (value != null) {
                                  ref
                                      .watch(createPostModelProvider)
                                      .updateModel(district: value);
                                }
                              },
                              onSaved: (String? value) {
                                ref
                                    .watch(createPostModelProvider)
                                    .updateModel(district: value);
                              },
                              value: districts[0],
                              items: districts
                                  .map<DropdownMenuItem<String>>((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                                labelText: AppLocalizations.of(context)!.city,
                                onSaved: (String? value) {
                                  ref
                                      .watch(createPostModelProvider)
                                      .updateModel(address: value);
                                },
                                validationMessage: AppLocalizations.of(context)!
                                    .validationAddress),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    cursorColor: AppColors.primary,
                                    onSaved: (newValue) {
                                      ref
                                          .watch(createPostModelProvider)
                                          .updateModel(size: newValue);
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      floatingLabelStyle:
                                          TextStyle(color: AppColors.primary),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.primary),
                                      ),
                                      label: Text(AppLocalizations.of(context)!
                                          .landSize),
                                      border: const OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .validationSize;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                ToggleButtons(
                                  direction: Axis.horizontal,
                                  onPressed: (int index) {
                                    ref
                                        .watch(toggleButtonProvider)
                                        .updateSizeToggle(index);
                                    ref
                                        .watch(createPostModelProvider)
                                        .updateModel(mesureUnit: index);
                                  },
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  selectedBorderColor: AppColors.primary,
                                  selectedColor: Colors.white,
                                  fillColor: AppColors.primary,
                                  color: AppColors.primary,
                                  isSelected: ref
                                      .watch(toggleButtonProvider)
                                      .sizeToggleClickState,
                                  constraints: const BoxConstraints(
                                    minHeight: 40.0,
                                    minWidth: 80.0,
                                  ),
                                  children: sizes,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(AppLocalizations.of(context)!
                                        .investmentStatus)),
                                const SizedBox(
                                  width: 16,
                                ),
                                ToggleButtons(
                                  direction: Axis.horizontal,
                                  onPressed: (int index) {
                                    ref
                                        .watch(toggleButtonProvider)
                                        .updateInvestToggle(index);

                                    ref
                                        .watch(createPostModelProvider)
                                        .updateModel(
                                            fundStatus:
                                                index == 0 ? true : false);
                                  },
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  selectedBorderColor: AppColors.primary,
                                  selectedColor: Colors.white,
                                  fillColor: AppColors.primary,
                                  color: AppColors.primary,
                                  isSelected: ref
                                      .watch(toggleButtonProvider)
                                      .investToggleClickState,
                                  constraints: const BoxConstraints(
                                    minHeight: 40.0,
                                    minWidth: 80.0,
                                  ),
                                  children: investType,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(AppLocalizations.of(context)!
                                        .machinery)),
                                const SizedBox(
                                  width: 16,
                                ),
                                ToggleButtons(
                                  direction: Axis.horizontal,
                                  onPressed: (int index) {
                                    ref
                                        .watch(toggleButtonProvider)
                                        .updateMachineryToggle(index);

                                    ref
                                        .watch(createPostModelProvider)
                                        .updateModel(
                                            equipmentStatus:
                                                index == 0 ? true : false);
                                  },
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  selectedBorderColor: AppColors.primary,
                                  selectedColor: Colors.white,
                                  fillColor: AppColors.primary,
                                  color: AppColors.primary,
                                  isSelected: ref
                                      .watch(toggleButtonProvider)
                                      .machineryToggleClickState,
                                  constraints: const BoxConstraints(
                                    minHeight: 40.0,
                                    minWidth: 80.0,
                                  ),
                                  children: machineryStatus,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        AppLocalizations.of(context)!.organic)),
                                const SizedBox(
                                  width: 16,
                                ),
                                ToggleButtons(
                                  direction: Axis.horizontal,
                                  onPressed: (int index) {
                                    ref
                                        .watch(toggleButtonProvider)
                                        .updateOrganicToggle(index);

                                    ref
                                        .watch(createPostModelProvider)
                                        .updateModel(
                                            organicStatus:
                                                index == 0 ? true : false);
                                  },
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  selectedBorderColor: AppColors.primary,
                                  selectedColor: Colors.white,
                                  fillColor: AppColors.primary,
                                  color: AppColors.primary,
                                  isSelected: ref
                                      .watch(toggleButtonProvider)
                                      .organicToggleClickState,
                                  constraints: const BoxConstraints(
                                    minHeight: 40.0,
                                    minWidth: 80.0,
                                  ),
                                  children: organicStatus,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(AppLocalizations.of(context)!
                                        .lawyerFee)),
                                const SizedBox(
                                  width: 16,
                                ),
                                ToggleButtons(
                                  direction: Axis.horizontal,
                                  onPressed: (int index) {
                                    ref
                                        .watch(toggleButtonProvider)
                                        .updateLawyerFeeToggle(index);

                                    if (index == 0) {
                                      ref
                                          .watch(createPostModelProvider)
                                          .updateModel(leagalFundAmount: "0%");
                                    } else if (index == 1) {
                                      ref
                                          .watch(createPostModelProvider)
                                          .updateModel(leagalFundAmount: "50%");
                                    } else {
                                      ref
                                          .watch(createPostModelProvider)
                                          .updateModel(
                                              leagalFundAmount: "100%");
                                    }
                                  },
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  selectedBorderColor: AppColors.primary,
                                  selectedColor: Colors.white,
                                  fillColor: AppColors.primary,
                                  color: AppColors.primary,
                                  isSelected: ref
                                      .watch(toggleButtonProvider)
                                      .lawyerFeeToggleClickState,
                                  constraints: const BoxConstraints(
                                    minHeight: 40.0,
                                    minWidth: 80.0,
                                  ),
                                  children: lawyerFeeStatus,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                label: Text(
                                    AppLocalizations.of(context)!.cropType),
                                labelStyle: TextStyle(color: AppColors.primary),
                                border: const OutlineInputBorder(
                                    gapPadding: 2,
                                    borderSide: BorderSide(width: 0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.primary)),
                              ),
                              onChanged: (String? value) {
                                // if (value != null) languageSelection = value;
                              },
                              onSaved: (String? value) {
                                ref
                                    .watch(createPostModelProvider)
                                    .updateModel(cropType: value);
                              },
                              value: cropTypes[0],
                              items: cropTypes
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

                                    // final signUpModel = ref
                                    //     .watch(signupModelProvider)
                                    //     .signupModel;
                                    // ref
                                    //     .watch(authenticationProvider)
                                    //     .updateUser(context, signUpModel);
                                    Navigator.of(context)
                                        .pushNamed('/imagePick');
                                  }
                                },
                                child:
                                    Text(AppLocalizations.of(context)!.next)),
                          ],
                        ));
                  })),
        ),
      ),
    );
  }
}
