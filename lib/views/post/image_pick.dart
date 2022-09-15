import 'dart:io';

import 'package:agropal/providers/button_notifier.dart';
import 'package:agropal/providers/create_post_notifier.dart';
import 'package:agropal/providers/file_provider.dart';
import 'package:agropal/utils/image_picker.dart';
import 'package:agropal/widgets/app_bar.dart';
import 'package:agropal/widgets/buttons.dart';
import 'package:agropal/widgets/picker_container.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagePickView extends StatelessWidget {
  const ImagePickView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    final maxWight = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: MainAppBar(
          isLeading: true,
        ),
        body: Consumer(builder: (context, ref, child) {
          return SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(children: [
                    Text(AppLocalizations.of(context)!.imageUploadDesc),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: pickerContainer(maxHeight, maxWight,
                                ref.read(fileProvider).fileOne),
                            onTap: () {
                              uploadImage(context, ref.watch(fileProvider), 0);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: InkWell(
                            child: pickerContainer(maxHeight, maxWight,
                                ref.read(fileProvider).fileTwo),
                            onTap: () {
                              uploadImage(context, ref.watch(fileProvider), 1);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: pickerContainer(maxHeight, maxWight,
                                ref.read(fileProvider).fileThree),
                            onTap: () {
                              uploadImage(context, ref.watch(fileProvider), 2);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: InkWell(
                            child: pickerContainer(maxHeight, maxWight,
                                ref.read(fileProvider).fileFour),
                            onTap: () {
                              uploadImage(context, ref.watch(fileProvider), 3);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    MainElevatedButton(
                        onPressed: () async {
                          if (ref.watch(fileProvider).fileOne != null) {
                            String? url = await ref
                                .watch(createPostModelProvider)
                                .postRepository
                                .uploadFile(
                                    context, ref.watch(fileProvider).fileOne!);
                            List<String> urls = [url!];
                            ref
                                .watch(createPostModelProvider)
                                .updateModel(images: urls);
                          }
                          // ignore: use_build_context_synchronously
                          ref
                              .watch(createPostModelProvider)
                              .postRepository
                              .createPost(context,
                                  ref.watch(createPostModelProvider).postModel);

                          ref.watch(createPostModelProvider).resetModel();
                          ref.watch(fileProvider).resetFiles();
                          ref.watch(toggleButtonProvider).resetButtons();
                        },
                        child: ref.watch(fileProvider).fileOne == null
                            ? Text(AppLocalizations.of(context)!.skip)
                            : Text(AppLocalizations.of(context)!.done))
                  ])));
        }));
  }

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

  uploadImage(BuildContext context, FileNotifier model, int index) async {
    final file = await selectImage(context);
    if (file != null) {
      if (index == 0) {
        model.updateFiles(fileOne: file);
      } else if (index == 1) {
        model.updateFiles(fileTwo: file);
      } else if (index == 2) {
        model.updateFiles(fileThree: file);
      } else if (index == 3) {
        model.updateFiles(fileFour: file);
      }
    }
  }
}
