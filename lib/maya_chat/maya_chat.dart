import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:maya/maya_chat/login_page.dart';
import 'package:maya/maya_chat/room_list_page.dart';
import 'package:provider/provider.dart';

class MayaChat extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  final Client client;
  const MayaChat(
      {super.key,
      required this.backgroundImage,
      required this.mainColor,
      required this.client});

  @override
  State<MayaChat> createState() => _MayaChatState();
}

class _MayaChatState extends State<MayaChat> {
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
