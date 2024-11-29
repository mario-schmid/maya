import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:maya/chat/login_page.dart';
import 'package:maya/chat/room_page.dart';
import 'package:provider/provider.dart';
import 'package:installed_apps/installed_apps.dart';

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

  void _openElement() async {
    bool? appIsInstalled = await InstalledApps.isAppInstalled('im.vector.app');
    if (appIsInstalled!) {
      InstalledApps.startApp('im.vector.app');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Element is not installed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final client = Provider.of<Client>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Chats'),
          backgroundColor: Color.lerp(widget.mainColor, Colors.black, 0.3),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
                icon: Image.asset('assets/images/icons/element.png'),
                onPressed: _openElement),
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
              leading: SizedBox(
                height: size.width * 0.12,
                width: size.width * 0.12,
                child: CircleAvatar(
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
