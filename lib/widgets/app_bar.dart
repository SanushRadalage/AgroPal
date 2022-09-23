import 'package:agropal/theme/colors.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isLeading;
  final List<Widget>? actions;

  const MainAppBar({this.isLeading = true, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 1,
      leading: isLeading
          ? IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_left,
                size: 38,
              ))
          : null,
      title: Text(
        "AgroPal",
        style: TextStyle(
            fontFamily: 'SF Pro Text',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.secondary),
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
