import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

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
      print('on change! $i');
      _listKey.currentState?.setState(() {});
    }, onInsert: (i) {
      print('on insert! $i');
      _listKey.currentState?.insertItem(i);
      _count++;
    }, onRemove: (i) {
      print('On remove $i');
      _count--;
      _listKey.currentState?.removeItem(i, (_, __) => const ListTile());
    }, onUpdate: () {
      print('On update');
    });
    super.initState();
  }

  final TextEditingController _sendController = TextEditingController();

  void _send() {
    widget.room.sendTextEvent(_sendController.text.trim());
    _sendController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.room.getLocalizedDisplayname()),
          backgroundColor: widget.mainColor,
          foregroundColor: Colors.white,
        ),
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
                                    return timeline.events[i]
                                                    .relationshipEventId !=
                                                null ||
                                            timeline.events[i]
                                                .getDisplayEvent(timeline)
                                                .body
                                                .contains('m.room.') ||
                                            timeline.events[i]
                                                .getDisplayEvent(timeline)
                                                .body
                                                .equals('Redacted')
                                        ? Container()
                                        : ScaleTransition(
                                            scale: animation,
                                            child: Opacity(
                                                opacity: timeline
                                                        .events[i].status.isSent
                                                    ? 1
                                                    : 0.5,
                                                child: ListTile(
                                                    leading: CircleAvatar(
                                                      foregroundImage: timeline
                                                                  .events[i]
                                                                  .senderFromMemoryOrFallback
                                                                  .avatarUrl ==
                                                              null
                                                          ? null
                                                          : NetworkImage(timeline
                                                              .events[i]
                                                              .senderFromMemoryOrFallback
                                                              .avatarUrl!
                                                              .getThumbnail(
                                                                widget.room
                                                                    .client,
                                                                width: 56,
                                                                height: 56,
                                                              )
                                                              .toString()),
                                                    ),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                              timeline.events[i]
                                                                  .senderFromMemoryOrFallback
                                                                  .calcDisplayname(),
                                                              style: TextStyle(
                                                                  color: Color.lerp(
                                                                      widget
                                                                          .mainColor,
                                                                      Colors
                                                                          .white,
                                                                      0.6))),
                                                        ),
                                                        Text(
                                                          timePast,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ],
                                                    ),
                                                    subtitle: Text(
                                                        timeline.events[i]
                                                            .getDisplayEvent(
                                                                timeline)
                                                            .body,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white)))));
                                  }))
                        ]);
                      })),
              Container(
                  height: 50,
                  width: double.infinity,
                  color: widget.mainColor,
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
