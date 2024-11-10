import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrix/matrix.dart';
import 'package:installed_apps/installed_apps.dart';

class RoomPage extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  final Room room;
  const RoomPage(
      {super.key,
      required this.backgroundImage,
      required this.mainColor,
      required this.room});

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late final Future<Timeline> _timelineFuture;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  int _count = 0;

  @override
  void initState() {
    _timelineFuture = widget.room.getTimeline(onChange: (i) {
      //print('on change! $i');
      _listKey.currentState?.setState(() {});
    }, onInsert: (i) {
      //print('on insert! $i');
      _listKey.currentState?.insertItem(i);
      _count++;
    }, onRemove: (i) {
      //print('On remove $i');
      _count--;
      _listKey.currentState?.removeItem(i, (_, __) => const ListTile());
    }, onUpdate: () {
      //print('On update');
    });
    super.initState();
  }

  final TextEditingController _sendController = TextEditingController();

  void _send() {
    widget.room.sendTextEvent(_sendController.text.trim());
    _sendController.clear();
  }

  void _openElement() async {
    bool? appIsInstalled = await InstalledApps.isAppInstalled('im.vector.app');
    if (appIsInstalled!) {
      InstalledApps.startApp('im.vector.app');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Element is not installed'.tr)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.room.getLocalizedDisplayname()),
            backgroundColor: Color.lerp(widget.mainColor, Colors.black, 0.3),
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                  icon: Image.asset('assets/images/icons/element.png'),
                  onPressed: _openElement)
            ]),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: widget.backgroundImage,
              fit: BoxFit.cover,
            )),
            child: SafeArea(
                child: Column(children: [
              Expanded(
                  child: FutureBuilder<Timeline>(
                      future: _timelineFuture,
                      builder: (context, snapshot) {
                        final timeline = snapshot.data;
                        if (timeline == null) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        _count = timeline.events.length;
                        return Column(children: [
                          Center(
                            child: TextButton(
                                onPressed: timeline.requestHistory,
                                child: const Text('Load more...',
                                    style: TextStyle(color: Colors.white))),
                          ),
                          const Divider(height: 1),
                          Expanded(
                              child: AnimatedList(
                                  key: _listKey,
                                  reverse: true,
                                  initialItemCount: timeline.events.length,
                                  itemBuilder: (context, i, animation) {
                                    String timePast = '';
                                    Duration diffTime = DateTime.now()
                                        .difference(
                                            timeline.events[i].originServerTs);
                                    if (diffTime.inHours > 24) {
                                      timePast = '${diffTime.inDays} d';
                                    } else if (diffTime.inMinutes > 60) {
                                      timePast = '${diffTime.inHours} h';
                                    } else {
                                      timePast = '${diffTime.inMinutes} min';
                                    }
                                    String eventBody = timeline.events[i]
                                        .getDisplayEvent(timeline)
                                        .body;
                                    return timeline.events[i]
                                                    .relationshipEventId !=
                                                null ||
                                            eventBody.contains('m.room.') ||
                                            eventBody.equals('Redacted')
                                        ? Container()
                                        : ScaleTransition(
                                            scale: animation,
                                            child: Opacity(
                                                opacity: timeline
                                                        .events[i].status.isSent
                                                    ? 1
                                                    : 0.5,
                                                child: Padding(
                                                    padding: EdgeInsets.all(
                                                        size.width * 0.025),
                                                    child: Row(children: [
                                                      SizedBox(
                                                        height:
                                                            size.width * 0.1,
                                                        width: size.width * 0.1,
                                                        child: CircleAvatar(
                                                            foregroundImage: timeline
                                                                        .events[
                                                                            i]
                                                                        .senderFromMemoryOrFallback
                                                                        .avatarUrl ==
                                                                    null
                                                                ? null
                                                                : NetworkImage(timeline
                                                                    .events[i]
                                                                    .senderFromMemoryOrFallback
                                                                    .avatarUrl!
                                                                    .getThumbnail(
                                                                      widget
                                                                          .room
                                                                          .client,
                                                                      width: 56,
                                                                      height:
                                                                          56,
                                                                    )
                                                                    .toString())),
                                                      ),
                                                      SizedBox(
                                                          width: size.width *
                                                              0.025),
                                                      Container(
                                                          padding: EdgeInsets.symmetric(
                                                              vertical: 4,
                                                              horizontal:
                                                                  size.width *
                                                                      0.02),
                                                          decoration: BoxDecoration(
                                                              color: Color.lerp(
                                                                  widget
                                                                      .mainColor,
                                                                  Colors.black,
                                                                  0.2),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          10))),
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    timeline
                                                                        .events[
                                                                            i]
                                                                        .senderFromMemoryOrFallback
                                                                        .calcDisplayname(),
                                                                    style: TextStyle(
                                                                        color: Color.lerp(
                                                                            widget
                                                                                .mainColor,
                                                                            Colors
                                                                                .white,
                                                                            0.8),
                                                                        fontSize:
                                                                            13)),
                                                                ConstrainedBox(
                                                                    constraints: BoxConstraints(
                                                                        maxWidth:
                                                                            size.width *
                                                                                0.66),
                                                                    child: Text(
                                                                        timeline
                                                                            .events[
                                                                                i]
                                                                            .getDisplayEvent(
                                                                                timeline)
                                                                            .body,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 14)))
                                                              ])),
                                                      SizedBox(
                                                          width: size.width *
                                                              0.025),
                                                      Expanded(
                                                          child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: SizedBox(
                                                                width:
                                                                    size.width *
                                                                        0.1,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: Text(
                                                                      timePast,
                                                                      style: TextStyle(
                                                                          fontSize: size.width *
                                                                              0.03,
                                                                          color:
                                                                              Colors.white)),
                                                                ),
                                                              )))
                                                    ]))));
                                  }))
                        ]);
                      })),
              Container(
                  height: 50,
                  width: double.infinity,
                  color: Color.lerp(widget.mainColor, Colors.black, 0.3),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(children: [
                    Expanded(
                        child: TextField(
                      controller: _sendController,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          hintText: 'Send message',
                          hintStyle: TextStyle(color: Colors.white)),
                    )),
                    IconButton(
                      icon: const Icon(Icons.send_outlined),
                      color: Colors.white,
                      onPressed: _send,
                    )
                  ]))
            ]))));
  }
}
