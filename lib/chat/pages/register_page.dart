import 'package:flutter/material.dart';
import 'package:maya/chat/pages/chat_page.dart';
import 'package:maya/chat/pages/login_page.dart';
import 'package:maya/chat/utils/constants.dart';
import 'package:maya/helper/maya_style.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  final bool isRegistering;
  final ImageProvider backgroundImage;
  final Color mainColor;
  const RegisterPage(
      {super.key,
      required this.isRegistering,
      required this.backgroundImage,
      required this.mainColor});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  Future<void> _signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    final email = _emailController.text;
    final password = _passwordController.text;
    final username = _usernameController.text;
    try {
      await supabase.auth.signUp(
          email: email, password: password, data: {'username': username});
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (BuildContext context, __, _) => ChatPage(
                  backgroundImage: widget.backgroundImage,
                  mainColor: widget.mainColor)));
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
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
            child: Form(
                key: _formKey,
                child: ListView(
                    padding:
                        EdgeInsets.fromLTRB(20, statusBarHeight + 20, 20, 20),
                    children: [
                      const Center(
                          child: Text('REGISTER',
                              style: TextStyle(
                                  fontSize: 28, color: Colors.white))),
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          label: Text('Email',
                              style: TextStyle(color: Colors.white70)),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      formSpacer,
                      TextFormField(
                        controller: _passwordController,
                        style: const TextStyle(color: Colors.white),
                        obscureText: true,
                        decoration: const InputDecoration(
                          label: Text('Password',
                              style: TextStyle(color: Colors.white70)),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          if (val.length < 6) {
                            return '6 characters minimum';
                          }
                          return null;
                        },
                      ),
                      formSpacer,
                      TextFormField(
                        controller: _usernameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          label: Text('Username',
                              style: TextStyle(color: Colors.white70)),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          final isValid =
                              RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(val);
                          if (!isValid) {
                            return '3-24 long with alphanumeric or underscore';
                          }
                          return null;
                        },
                      ),
                      formSpacer,
                      ElevatedButton(
                        style: MayaStyle().mainButtonStyle(widget.mainColor),
                        onPressed: _isLoading ? null : _signUp,
                        child: const Text('Register'),
                      ),
                      formSpacer,
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                    pageBuilder:
                                        (BuildContext context, __, _) =>
                                            LoginPage(
                                                backgroundImage:
                                                    widget.backgroundImage,
                                                mainColor: widget.mainColor)));
                          },
                          child: const Text('I already have an account',
                              style: TextStyle(color: Colors.white70)))
                    ]))));
  }
}
