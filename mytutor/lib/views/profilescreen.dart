import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user.dart';
import 'loginscreen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late double screenHeight, screenWidth, ctrwidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800) {
      ctrwidth = screenWidth / 1.5;
    }
    if (screenWidth < 800) {
      ctrwidth = screenWidth;
    }
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Material App Bar'),
      // ),
      body: Center(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.user.name.toString()),
            accountEmail: Text(widget.user.email.toString()),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://ziclife.com/wp-content/uploads/2020/08/best-cute-avata-picture.jpg"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 350, 32, 32),
            child: SizedBox(
              width: screenWidth,
              height: 60,
              child: ElevatedButton(
                child: const Text("Logout",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                  Fluttertoast.showToast(
                      msg: "Logout",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0);
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
