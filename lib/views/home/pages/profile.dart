import 'package:agropal/models/user.dart';
import 'package:agropal/providers/auth_notifier.dart';
import 'package:agropal/theme/colors.dart';
import 'package:agropal/widgets/divider.dart';
import 'package:agropal/widgets/image_slector.dart';
import 'package:agropal/widgets/profile_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profile extends ConsumerWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<User>(
        stream: ref.watch(authenticationProvider).getUserDetails(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      CircleAvatar(
                          radius: 35,
                          backgroundImage: snapshot.data?.avatar != null
                              ? NetworkImage(snapshot.data!.avatar!)
                              : const NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/agropal-532e9.appspot.com/o/user.png?alt=media&token=3711fab4-1f20-4c33-a562-a382c94acdec")),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  50,
                                ),
                              ),
                              color: AppColors.background,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(3, 4),
                                  color: Colors.black.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 3,
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: InkWell(
                              onTap: () async {
                                final file = await selectImage(context);
                                if (file != null) {
                                  // ignore: use_build_context_synchronously
                                  ref
                                      .watch(authenticationProvider)
                                      .uploadAvatar(context, file);
                                }
                              },
                              child: const Icon(
                                Icons.edit,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    snapshot.data?.name ?? '',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    snapshot.data?.role ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    child: profileOptions(Icons.list, "My Posts"),
                    onTap: () {
                      Navigator.of(context).pushNamed('/userPosts');
                    },
                  ),
                  customDivider(),
                  profileOptions(Icons.settings, "Settings"),
                  customDivider(),
                  profileOptions(Icons.help_center, "Help & Support"),
                  customDivider(),
                  profileOptions(Icons.privacy_tip, "Privacy Policy"),
                  customDivider(),
                  profileOptions(Icons.article, "Terms & Conditions"),
                  customDivider(),
                  InkWell(
                      onTap: () =>
                          ref.watch(authenticationProvider).signOut(context),
                      child: profileOptions(Icons.logout, "Sign Out")),
                  customDivider(),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, top: 8, bottom: 8),
                    child: InkWell(
                      // onTap: ref
                      //     .watch(authenticationProvider)
                      //     .deleteAccount(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.delete_forever,
                            color: AppColors.error,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text("Delete Account",
                              style: TextStyle(
                                  fontSize: 16, color: AppColors.error))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
