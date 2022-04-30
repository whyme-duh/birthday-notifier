import 'package:app/Auth/Authenticate.dart';
import 'package:app/functionality/friendlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProfile?>(context);
    return user == null ? Authenticate() : FriendList();
  }
}
