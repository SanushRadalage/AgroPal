import 'package:agropal/providers/button_notifier.dart';
import 'package:agropal/providers/create_post_notifier.dart';
import 'package:agropal/providers/file_provider.dart';
import 'package:agropal/theme/colors.dart';
import 'package:agropal/widgets/buttons.dart';
import 'package:agropal/widgets/image_slector.dart';
import 'package:agropal/widgets/picker_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagePickView extends ConsumerWidget {
  const ImagePickView({Key? key}) : super(key: key);

  Future<bool> _onWillPop(BuildContext context, WidgetRef ref) async {
    return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Discard images'),
                  content: const Text(
                      'This will discard your images without saving.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.watch(fileProvider).resetFiles();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Discard',
                        style: TextStyle(color: AppColors.error),
                      ),
                    ),
                  ],
                ))) ??
        false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxHeight = MediaQuery.of(context).size.height;
    final maxWight = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context, ref);
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 1,
            leading: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Discard images'),
                            content: const Text(
                                'This will discard your images without saving.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref.watch(fileProvider).resetFiles();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Discard',
                                  style: TextStyle(color: AppColors.error),
                                ),
                              ),
                            ],
                          ));
                },
                icon: const Icon(
                  Icons.arrow_left,
                  size: 38,
                )),
            title: Text(
              "AgroPal",
              style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.secondary),
            ),
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
                                uploadImage(
                                    context, ref.watch(fileProvider), 0);
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
                                uploadImage(
                                    context, ref.watch(fileProvider), 1);
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
                                uploadImage(
                                    context, ref.watch(fileProvider), 2);
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
                                uploadImage(
                                    context, ref.watch(fileProvider), 3);
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
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                            ref.watch(fileProvider).addImages();
                            if (ref.watch(fileProvider).images.isNotEmpty) {
                              List<String> urls = await ref
                                  .watch(createPostModelProvider)
                                  .postRepository
                                  .uploadFiles(
                                      context, ref.watch(fileProvider).images);
                              ref
                                  .watch(createPostModelProvider)
                                  .updateModel(images: urls);
                            }
                            // ignore: use_build_context_synchronously
                            ref
                                .watch(createPostModelProvider)
                                .postRepository
                                .createPost(
                                    context,
                                    ref
                                        .watch(createPostModelProvider)
                                        .postModel);

                            ref.watch(createPostModelProvider).resetModel();
                            ref.watch(fileProvider).resetFiles();
                            ref.watch(toggleButtonProvider).resetButtons();
                          },
                          child: ref.watch(fileProvider).fileOne == null
                              ? Text(AppLocalizations.of(context)!.skip)
                              : Text(AppLocalizations.of(context)!.done))
                    ])));
          })),
    );
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
