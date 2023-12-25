List<int> getHaabDate(int haabDays) {
  return [haabDays % 20, haabDays ~/ 20];
}
