import 'package:ff2/forum.screen.dart';
import 'package:ff2/home.screen.dart';
import 'package:ff2/login.screen.dart';
import 'package:ff2/profile.screen.dart';
import 'package:ff2/register.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import './global.dart';

void main() async {
  await ff.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fire Flutter Demo',
      initialRoute: 'home',
      getPages: [
        GetPage(name: 'home', page: () => HomeScreen()),
        GetPage(name: 'login', page: () => LoginScreen()),
        GetPage(name: 'register', page: () => RegisterScreen()),
        GetPage(name: 'profile', page: () => ProfileScreen()),
        GetPage(name: 'forum', page: () => ForumScreen())
      ],
    );
  }
}
