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
  static const List<Widget> _widgetOptions = <Widget>[
    Feed(),
    ChatList(),
    Jobs(),
    Profile()
  ];

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final bottonNavProvider = ref.watch(bottonNavigationProvider);
      return Scaffold(
        appBar: MainAppBar(isLeading: false),
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
            bottonNavProvider.currentIndex = value;
          },
        ),
      );
    });
  }
}
