import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:maya/maya_chat/login_page.dart';
import 'package:maya/maya_chat/room_page.dart';
import 'package:provider/provider.dart';

class RoomListPage extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  const RoomListPage(
      {super.key, required this.backgroundImage, required this.mainColor});

  @override
  _RoomListPageState createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  void _logout() async {
    final client = Provider.of<Client>(context, listen: false);
    await client.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (_) => LoginPage(
              backgroundImage: widget.backgroundImage,
              mainColor: widget.mainColor)),
      (route) => false,
    );
  }

  void _join(Room room) async {
    if (room.membership != Membership.join) {
      await room.join();
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RoomPage(
            backgroundImage: widget.backgroundImage,
            mainColor: widget.mainColor,
            room: room),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<Client>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Chats'),
          backgroundColor: widget.mainColor,
          foregroundColor: Colors.white,
          actions: [
            IconButton(icon: const Icon(Icons.logout), onPressed: _logout)
          ]),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: widget.backgroundImage,
          fit: BoxFit.cover,
        )),
        child: StreamBuilder(
          stream: client.onSync.stream,
          builder: (context, _) => ListView.builder(
            itemCount: client.rooms.length,
            itemBuilder: (context, i) => ListTile(
              leading: CircleAvatar(
                foregroundImage: client.rooms[i].avatar == null
                    ? null
                    : NetworkImage(client.rooms[i].avatar!
                        .getThumbnail(
                          client,
                          width: 56,
                          height: 56,
                        )
                        .toString()),
              ),
              title: Row(
                children: [
                  Expanded(
                      child: Text(client.rooms[i].getLocalizedDisplayname(),
                          style: TextStyle(color: Colors.white))),
                  if (client.rooms[i].notificationCount > 0)
                    Material(
                        borderRadius: BorderRadius.circular(99),
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                              client.rooms[i].notificationCount.toString(),
                              style: TextStyle(color: Colors.white)),
                        ))
                ],
              ),
              /*subtitle: Text(client.rooms[i].lastEvent?.body ?? 'No messages',
                  maxLines: 1, style: TextStyle(color: Colors.white)),*/
              onTap: () => _join(client.rooms[i]),
            ),
          ),
        ),
      ),
    );
  }
}
