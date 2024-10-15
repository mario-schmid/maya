import 'package:flutter/material.dart';
import '../chat/pages/chat_page.dart';
import '../chat/pages/register_page.dart';
import '../chat/utils/constants.dart';

/// Page to redirect users to the appropriate page depending on the initial auth state
class SplashPage extends StatefulWidget {
  final Color mainColor;
  const SplashPage({super.key, required this.mainColor});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    // await for for the widget to mount
    await Future.delayed(Duration.zero);

    final session = supabase.auth.currentSession;
    if (session == null) {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (BuildContext context, __, _) => RegisterPage(
                  isRegistering: false, mainColor: widget.mainColor)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (BuildContext context, __, _) =>
                  ChatPage(mainColor: widget.mainColor)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: preloader);
  }
}
