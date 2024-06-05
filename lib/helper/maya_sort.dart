class MayaSort {
  Map<int, Map<int, List<List<int>>>> sortArrayIndex(
      Map<int, Map<int, List<List<int>>>> map) {
    List<MapEntry<int, Map<int, List<List<int>>>>> list = map.entries.toList();
    list.sort((a, b) => a.key.compareTo(b.key));
    return Map.fromEntries(list);
  }

  Map<int, Map<int, Map<String, dynamic>>> sortMapYear(
      Map<int, Map<int, Map<String, dynamic>>> map) {
    List<MapEntry<int, Map<int, Map<String, dynamic>>>> list =
        map.entries.toList();
    list.sort((a, b) => a.key.compareTo(b.key));
    return Map.fromEntries(list);
  }

  Map<int, Map<String, dynamic>> sortMapDay(
      Map<int, Map<String, dynamic>> map) {
    List<MapEntry<int, Map<String, dynamic>>> list = map.entries.toList();
    list.sort((a, b) => a.key.compareTo(b.key));
    return Map.fromEntries(list);
  }
}
