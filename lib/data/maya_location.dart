class Location {
  String type;
  int elementIndex;

  Location(this.type, this.elementIndex);

  Map<String, dynamic> toJson() {
    return {'type': type, 'elementIndex': elementIndex};
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(map['type'], map['elementIndex']);
  }
}
