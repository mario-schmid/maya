import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:maya/chat/login_page.dart';
import 'package:maya/chat/room_list_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  final Client client;
  const MainPage(
      {super.key,
      required this.backgroundImage,
      required this.mainColor,
      required this.client});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => Provider<Client>(
              create: (context) => widget.client,
              child: child,
            ),
        home: widget.client.isLogged()
            ? RoomListPage(
                backgroundImage: widget.backgroundImage,
                mainColor: widget.mainColor)
            : LoginPage(
                backgroundImage: widget.backgroundImage,
                mainColor: widget.mainColor));
  }
}
