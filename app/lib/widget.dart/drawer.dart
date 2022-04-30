import 'package:flutter/material.dart';

class DrawerMethods extends StatelessWidget {
  String title;
  Widget link;
  DrawerMethods({
    required this.title,
    required this.link,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => link));
        },
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
              child: Text(title,
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 2,
                  ))),
        )),
      ),
    );
  }
}
