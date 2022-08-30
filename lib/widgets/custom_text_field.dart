import 'package:agropal/theme/colors.dart';
import 'package:agropal/utils/validator.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final Function onSaved;
  final String validationMessage;
  final int? maxLength;

  CustomTextField(
      {required this.labelText,
      required this.onSaved,
      required this.validationMessage,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        cursorColor: AppColors.primary,
        onSaved: onSaved as void Function(String?)?,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelStyle: TextStyle(color: AppColors.primary),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (!Validator.validateSpecialChars(value)) {
            return validationMessage;
          }
          return null;
        },
      ),
    );
  }
}
