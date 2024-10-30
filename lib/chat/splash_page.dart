import 'package:flutter/material.dart';
import 'package:maya/main.dart';
import '../chat/pages/chat_page.dart';
import '../chat/pages/register_page.dart';
import '../chat/utils/constants.dart';

/// Page to redirect users to the appropriate page depending on the initial auth state
class SplashPage extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  const SplashPage(
      {super.key, required this.backgroundImage, required this.mainColor});

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
          navigatorKey.currentContext!,
          PageRouteBuilder(
              pageBuilder: (BuildContext context, __, _) => RegisterPage(
                  isRegistering: false,
                  backgroundImage: widget.backgroundImage,
                  mainColor: widget.mainColor)));
    } else {
      Navigator.pushReplacement(
          navigatorKey.currentContext!,
          PageRouteBuilder(
              pageBuilder: (BuildContext context, __, _) => ChatPage(
                  backgroundImage: widget.backgroundImage,
                  mainColor: widget.mainColor)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: preloader);
  }
}
