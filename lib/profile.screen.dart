import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ff2/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  final emailController = TextEditingController(text: ff.user.email);
  final displayNameController =
      TextEditingController(text: ff.user.displayName);

  final occupationController =
      TextEditingController(text: ff.data['occupation']);

  String gender = ff.data['gender'];
  DateTime birthday = DateTime.now();

  bool loading = false;
  double uploadProgress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text('Email: ${ff.user.email}'),
              TextFormField(
                key: ValueKey('nickname'),
                controller: displayNameController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Nickname"),
              ),
              SizedBox(height: 20),
              Text('Gender'),
              RadioListTile(
                value: 'M',
                title: Text("Male"),
                key: ValueKey('genderM'),
                groupValue: gender,
                onChanged: (str) {
                  setState(() => gender = str);
                },
              ),
              RadioListTile(
                value: 'F',
                title: Text("Female"),
                key: ValueKey('genderF'),
                groupValue: gender,
                onChanged: (str) {
                  setState(() => gender = str);
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                key: ValueKey('occupation'),
                controller: occupationController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Occupation"),
              ),
              SizedBox(height: 30),
              RaisedButton(
                child: loading ? CircularProgressIndicator() : Text("Submit"),
                onPressed: () async {
                  setState(() => loading = true);
                  try {
                    await ff.updateProfile({
                      'displayName': displayNameController.text,
                      'gender': gender,
                      'more_key': 'more_vlaue',
                    }, meta: {
                      'public': {
                        'any_more_key': 'and_more_value',
                      }
                    });
                    Get.snackbar('Update', 'Profile updated!');
                  } catch (e) {
                    print('error: $e');
                  } finally {
                    setState(() => loading = false);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
