import 'dart:io';

List<bool> next_generation(List<bool> state, List<int> changes) {

  int value(int s, int f) {
    var v = 0;
    var b = 1;
    for (var p = s; p < f; p++) {
      b = b << 1;
      v = v + (state[p] ? b : 0);
    }
    return v;
  }

  bool next_plant(int pos) {
    return changes.any((pattern) => value(pos-2, pos+3) == pattern);
  }

  var result = List();
  for (var c = 2; c < state.length-2; c++) {
    if (next_plant(c)) {
      result.add(c);
    }
  }
  for (var i = 0; i < state.length; i++) {
    state[i] = result.contains(i);
  }
  return state;
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

  var s = content[0].substring("initial state: ".length);
  var state = List.filled(generations, false) + List.generate(s.length, (i) => (s.substring(i, i+1) == '#')) + List.filled(generations, false);
  var changes = List<int>();
  content.sublist(2).forEach((line) {
    var r = RegExp(r"(.{0,5})\s=>\s(.)");
    var m = r.firstMatch(line);

    if (m.group(2) == '#') {
      changes.add(value(m.group(1)));
    }
  });

  print(state.map((p) => p ? '#' : '.').join());
  for (var n = 0; n < generations; n++) {
    state = next_generation(state, changes);
    print(state.map((p) => p ? '#' : '.').join());
//    print(n);
  }

  var total = 0;
  for (var n = 0; n < state.length; n++) {
    if (state[n]) {
      total += n-generations;
    }
  }
  print(total);
}
