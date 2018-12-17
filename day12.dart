import 'dart:io';

List<int> next_generation(List<int> state, List<int> changes) {

  int value(int s, int f) {
    var v = 0;
    var b = 1;
    for (var p = s; p < f; p++) {
      b = b << 1;
      v = v + (state.contains(p) ? b : 0);
    }
    return v;
  }

  bool next_plant(int pos) {
    return changes.any((pattern) => value(pos-2, pos+3) == pattern);
  }

  var result = List<int>();
  for (var c = state.first-2; c < state.last+3; c++) {
    if (next_plant(c)) {
      result.add(c);
    }
  }
  return result;
}

main() async {
  int value(String s) {
    var v = 0;
    var b = 1;
    for (var p = 0; p < s.length; p++) {
      b = b << 1;
      v = v + (s[p] == '#' ? b : 0);
    }
    return v;
  }

  var generations = 20;
//  generations = 50000000000;

  var content = await File('day12.txt').readAsLines();
//  content = await File('test.txt').readAsLines();

  var state = List<int>();
  var s = content[0].substring("initial state: ".length);
  for (var i = 0; i < s.length; i++) {
    if (s.substring(i, i+1) == '#') {
      state.add(i);
    }
  }

  var changes = List<int>();
  content.sublist(2).forEach((line) {
    var r = RegExp(r"(.{0,5})\s=>\s(.)");
    var m = r.firstMatch(line);

    if (m.group(2) == '#') {
      changes.add(value(m.group(1)));
    }
  });

  for (var n = 0; n < generations; n++) {
    state.sort();
    state = next_generation(state, changes);
    print(n);
  }

  print(state.reduce((a, b) => a + b));
}
