import 'package:flutter/material.dart';
import 'package:maya/chat/pages/chat_page.dart';
import 'package:maya/chat/utils/constants.dart';
import 'package:maya/helper/maya_style.dart';
import 'package:maya/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  const LoginPage(
      {super.key, required this.backgroundImage, required this.mainColor});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushReplacement(
          navigatorKey.currentContext!,
          PageRouteBuilder(
              pageBuilder: (BuildContext context, __, _) => ChatPage(
                  backgroundImage: widget.backgroundImage,
                  mainColor: widget.mainColor)));
    } on AuthException catch (error) {
      navigatorKey.currentContext!.showErrorSnackBar(message: error.message);
    } catch (_) {
      navigatorKey.currentContext!
          .showErrorSnackBar(message: unexpectedErrorMessage);
    }
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
            child: ListView(
                padding: EdgeInsets.fromLTRB(20, statusBarHeight + 20, 20, 20),
                children: [
                  const Center(
                      child: Text('LOGIN',
                          style: TextStyle(fontSize: 28, color: Colors.white))),
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white70)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  formSpacer,
                  TextFormField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white70)),
                    obscureText: true,
                  ),
                  formSpacer,
                  ElevatedButton(
                      style: MayaStyle().mainButtonStyle(widget.mainColor),
                      onPressed: _isLoading ? null : _signIn,
                      child: const Text('Login'))
                ])));
  }
}
