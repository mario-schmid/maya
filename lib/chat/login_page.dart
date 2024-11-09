import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrix/matrix.dart';
import 'package:maya/helper/maya_style.dart';
import 'package:maya/chat/room_list_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  const LoginPage(
      {super.key, required this.backgroundImage, required this.mainColor});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameTextField = TextEditingController();
  final TextEditingController _passwordTextField = TextEditingController();

  final String homeserver = 'matrix.morgenfrost.com';
  bool _loading = false;

  void _login() async {
    setState(() {
      _loading = true;
    });

    try {
      final client = Provider.of<Client>(context, listen: false);
      await client.checkHomeserver(Uri.https(homeserver.trim(), ''));
      await client.login(
        LoginType.mLoginPassword,
        password: _passwordTextField.text,
        identifier: AuthenticationUserIdentifier(user: _usernameTextField.text),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (_) => RoomListPage(
                backgroundImage: widget.backgroundImage,
                mainColor: widget.mainColor)),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: widget.backgroundImage,
              fit: BoxFit.cover,
            )),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  SizedBox(height: statusBarHeight),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextField(
                      controller: _usernameTextField,
                      readOnly: _loading,
                      autocorrect: false,
                      style: MayaStyle().textFieldStyle(),
                      decoration: MayaStyle().textFieldInputDecoration(
                          widget.mainColor, 'Username'.tr),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextField(
                      controller: _passwordTextField,
                      readOnly: _loading,
                      autocorrect: false,
                      obscureText: true,
                      style: MayaStyle().textFieldStyle(),
                      decoration: MayaStyle().textFieldInputDecoration(
                          widget.mainColor, 'Password'.tr),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 44,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: MayaStyle().mainButtonStyle(widget.mainColor),
                      onPressed: _loading ? null : _login,
                      child: _loading
                          ? const LinearProgressIndicator()
                          : Text('Login'.tr),
                    ),
                  ),
                  /*Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                              height: 44,
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: MayaStyle()
                                      .mainButtonStyle(widget.mainColor),
                                  onPressed: () {},
                                  child: Text('Get Access'.tr)))))*/
                ]))));
  }
}
