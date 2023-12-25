class Event {
  List<String>? event = List.generate(4, (index) => '');

  // 0 -> begin
  // 1 -> end
  // 2 -> title
  // 3 -> description

  Event(this.event);
}
