import 'dart:io';
import 'package:agropal/utils/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

Future<File?> selectImage(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              child: Text(AppLocalizations.of(context)!.camera),
              onPressed: () async {
                final file = await handleTakePhoto(context);
                Navigator.of(context).pop(file);
              },
            ),
            SimpleDialogOption(
              child: Text(AppLocalizations.of(context)!.gallery),
              onPressed: () async {
                final file = await handleChoosePhoto(context);
                Navigator.of(context).pop(file);
              },
            ),
            // ignore: prefer_const_constructors
            Divider(
              height: 2.0,
            ),
            SimpleDialogOption(
              child: Text(AppLocalizations.of(context)!.cancel,
                  style: Theme.of(context).textTheme.button),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
          ],
        );
      });
}
