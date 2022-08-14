import 'package:agropal/widgets/headline.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isLeading;
  final List<Widget>? actions;

  MainAppBar({this.isLeading = true, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: isLeading,
      centerTitle: true,
      elevation: 1,
      leading: isLeading
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_left,
                size: 38,
              ))
          : null,

      title: Headline(
        size: 20,
      ),
      // SizedBox(
      //   child: Image.asset(
      //     'assets/images/logo.png',
      //     width: 100,
      //   ),
      // ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
