import 'dart:async';

import 'package:ff2/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// User information
  User user;

  /// Registration
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final displayNameController = TextEditingController();
  String gender;

  ///
  bool loading = false;

  @override
  void initState() {
    Timer(Duration(milliseconds: 200),
        () => Get.toNamed('forum', arguments: {'category': 'qna'}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home screen'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                  stream: ff.userChange,
                  builder: (context, snapshot) {
                    print('userChange => ${snapshot.data}');
                    if (ff.user == null) {
                      return Row(
                        children: [
                          RaisedButton(
                            onPressed: () => Get.toNamed('register'),
                            child: Text('Register'),
                          ),
                          RaisedButton(
                            onPressed: () => Get.toNamed('login'),
                            child: Text('login'),
                          ),
                        ],
                      );
                    }
                    return Column(children: [
                      Text('UID: ${ff.user.uid}'),
                      Text('displayName: ${ff.user.displayName}'),
                      Text('gender: ${ff.data['gender']}'),
                      Text('occupation: ${ff.data['occupation']}'),
                      Text('isAdmin: ${ff.isAdmin}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RaisedButton(
                            onPressed: () => Get.toNamed('profile'),
                            child: Text('Profile'),
                          ),
                          RaisedButton(
                            onPressed: ff.logout,
                            child: Text('Logout'),
                          ),
                        ],
                      ),
                    ]);
                  }),
              Divider(),
              Row(
                children: [
                  RaisedButton(
                      child: Text('QnA'),
                      onPressed: () =>
                          Get.toNamed('forum', arguments: {'category': 'qna'})),
                  RaisedButton(
                      child: Text('Discussion'),
                      onPressed: () => Get.toNamed('forum',
                          arguments: {'category': 'discussion'})),
                  RaisedButton(
                      child: Text('Reminders'),
                      onPressed: () => Get.toNamed('forum',
                          arguments: {'category': 'reminder'})),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
