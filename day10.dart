import 'dart:io';
import 'dart:math';

class Position {
  int x, y;
  Position(this.x, this.y);
  @override
  String toString() {
    return "($x, $y)";
  }
}
class Signal {
  Position position;
  int vx, vy;

  at(int time) {
    return Position(position.x + time*vx, position.y + time*vy);
  }
  Signal(x, y, this.vx, this.vy) {
    position = Position(x, y);
  }

  @override
  String toString() {
    return "Signal($position, $vx, $vy)";
  }
}

print_positions(List<Position> positions, int ox, int oy, int w, int h) {
  var grid = List.generate(h, (_) => List.generate(w, (p) => '.'));
  positions.forEach((p) => grid[p.y-oy][p.x-ox] = '#');
  for (var y = 0; y < grid.length; y++) {
    for (var x = 0; x < grid[y].length; x++) {
      stdout.write(grid[y][x]);
    }
    stdout.write('\n');
  }
}

main() async {
  var content = await File('day10.txt').readAsLines();
//  content = await File('test.txt').readAsLines();

  // position=< 9,  1> velocity=< 0,  2>
  var r = RegExp(r"position=\<\s*(-*\d+),\s*(-*\d+)\> velocity=\<\s*(-*\d+),\s*(-*\d+)\>");
  var signals = content.where((line) => r.firstMatch(line) != null)
      .map((line) => r.firstMatch(line)).map((m) => Signal(int.parse(m.group(1)),
          int.parse(m.group(2)),
          int.parse(m.group(3)),
          int.parse(m.group(4))));
  print(signals);

  for (var time = 0; true; time++) {
    var positions = signals.map<Position>((signal) => signal.at(time)).toList();
    List<int> positions_x = positions.map<int>((p) => p.x).toList();
    List<int> positions_y = positions.map<int>((p) => p.y).toList();

    int minx = positions_x.reduce(min);
    int maxx = positions_x.reduce(max);
    int miny = positions_y.reduce(min);
    int maxy = positions_y.reduce(max);

    if (maxx-minx < signals.length && maxy-miny < signals.length) {
      print(time);
      print_positions(positions, minx, miny, maxx-minx+1, maxy-miny+1);
    }
  }
}
