import 'package:ff2/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  /// Registration
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final displayNameController = TextEditingController();
  String gender;

  ///
  bool loading = false;

  @override
  void initState() {
    emailController.text =
        "email" + (DateTime.now().millisecond.toString()) + '@gmail.com';
    passwordController.text = '12345a';
    displayNameController.text = 'nick';
    gender = 'M';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // RaisedButton(
              //   child: Text('Google Sign-in'),
              //   onPressed: Service.signInWithGoogle,
              // ),
              // RaisedButton(
              //   child: Text('Facebook Sign-in'),
              //   onPressed: Service.signInWithFacebook,
              // ),

              SizedBox(height: 32),

              TextFormField(
                key: ValueKey('email'),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email Address"),
              ),
              TextFormField(
                key: ValueKey('password'),
                controller: passwordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Password"),
              ),
              TextFormField(
                key: ValueKey('nickname'),
                controller: displayNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Nickname"),
              ),
              SizedBox(height: 16),
              Text('Gender - $gender'),
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
              SizedBox(height: 32),
              RaisedButton(
                child: loading ? CircularProgressIndicator() : Text("Submit"),
                onPressed: () async {
                  setState(() => loading = true);
                  try {
                    await ff.register({
                      'email': emailController.text,
                      'password': passwordController.text,
                      'displayName': displayNameController.text,
                      'gender': gender,
                      'any': 'you can add any extra data',
                    }, meta: {
                      'public': {
                        'public_data': true,
                        'any_data': true,
                      },
                      // 'custom': {
                      //   'should_be': 'error',
                      // }
                    });
                    Get.toNamed('home');
                  } catch (e) {
                    print(e);
                    Get.snackbar('Error', e.toString());
                  }
                  setState(() => loading = false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
