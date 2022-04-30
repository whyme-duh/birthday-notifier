import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final Widget Heading;
  final Widget Icons;
  final Function func;
  // final Function func;
  const TopBar({
    Key? key,
    required this.appBar,
    required this.Heading,
    required this.Icons,
    required this.func,
    //  required this.func
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        TextButton(
          child: Icons,
          onPressed: () {
            func();
          },
        )
      ],
      iconTheme: IconThemeData(color: Colors.black),
      title: Heading,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color.fromRGBO(119, 230, 196, 1),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
