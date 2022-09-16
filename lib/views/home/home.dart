import 'package:agropal/providers/app_bar_action_notifier.dart';
import 'package:agropal/providers/bottom_navigation_provider.dart';
import 'package:agropal/theme/colors.dart';
import 'package:agropal/views/home/pages/chat.dart';
import 'package:agropal/views/home/pages/feed.dart';
import 'package:agropal/views/home/pages/jobs.dart';
import 'package:agropal/views/home/pages/profile.dart';
import 'package:agropal/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends StatelessWidget {
  static final List<Widget> _widgetOptions = <Widget>[
    Feed(),
    const ChatList(),
    const Text("Create Post"),
    const Jobs(),
    const Profile()
  ];

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final bottonNavProvider = ref.watch(bottonNavigationProvider);
      return Scaffold(
        appBar: MainAppBar(
          isLeading: false,
          actions: [
            ref.watch(actionStateProvider).isVisible
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                  child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Text('GeeksforGeeks'),
                                  ],
                                ),
                              ));
                            });
                      },
                      child: const Icon(
                        Icons.manage_search,
                        size: 25,
                      ),
                    ),
                  )
                : const Text("")
          ],
        ),
        body: SafeArea(
          child: Center(
            child: _widgetOptions.elementAt(bottonNavProvider.currentIndex),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 5,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: 'Create Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: 'My Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          currentIndex: bottonNavProvider.currentIndex,
          selectedItemColor: AppColors.primary,
          onTap: (value) {
            if (value == 0 || value == 2) {
              ref.watch(actionStateProvider).update(isVisible: true);
            } else {
              ref.watch(actionStateProvider).update(isVisible: false);
            }

            if (value == 2) {
              Navigator.of(context).pushNamed('/createPost');
            } else {
              bottonNavProvider.currentIndex = value;
            }
          },
        ),
      );
    });
  }
}
