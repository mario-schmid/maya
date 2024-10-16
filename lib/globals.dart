class Globals {
  static final Map<int, Map<int, List<List<int>>>> _arrayIndex =
      <int, Map<int, List<List<int>>>>{};

  get arrayIndex => _arrayIndex;
}

// 0 -> leading number
// 1 -> position Index
// 2 -> arrangement (kind of list item -> 0: Event, 1: Note, 2: Task, 3: Alarm)
// 3 -> index of all created list items
// 4 -> index of all visible list items (without deleted list items)
