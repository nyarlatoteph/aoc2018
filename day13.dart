import 'dart:io';

class Point extends Object {
  int x;
  int y;
  Point(this.x, this.y);

  @override
  String toString() {
    return "($x, $y)";
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  bool operator ==(other) {
    return other is Point && x == other.x && y == other.y;
  }
}

Point new_position(Point position, Point speed) {
  var nx = position.x + speed.x;
  var ny = position.y + speed.y;
  return Point(nx, ny);
}

bool advance(tracks, List<Point> carts, List<Point> speeds, List<int> turns) {
  for (var n = 0; n < carts.length; n++) {
    var c = tracks[carts[n].y][carts[n].x];
    if (c == '/') {
      speeds[n] = Point(-speeds[n].y, -speeds[n].x);
    } else if (c == '\\') {
      speeds[n] = Point(speeds[n].y, speeds[n].x);
    } else if (c == '+') {
      if (turns[n] == 0) {
        speeds[n] = Point(speeds[n].y, -speeds[n].x);
      } else if (turns[n] == 2) {
        speeds[n] = Point(-speeds[n].y, speeds[n].x);
      }
      turns[n] = (turns[n] + 1) % 3;
    }
    carts[n] = new_position(carts[n], speeds[n]);
  }
  return carts.toSet().length != carts.length;
}


print_tracks(tracks, List<Point> carts, List<Point> speeds) {
  List<String> t = List<String>.from(tracks);
  for (var n = 0; n < carts.length; n++) {
    var c = 'o';
    if (speeds[n].x > 0) {
      c = ">";
    } else if (speeds[n].x < 0) {
      c = "<";
    } else if (speeds[n].y > 0) {
      c = "v";
    } else if (speeds[n].y < 0) {
      c = "^";
    }
    t[carts[n].y] = t[carts[n].y].replaceRange(carts[n].x, carts[n].x+1, c);
  }
  for (int y = 0; y < t.length; y++) {
    print(t[y]);
  }
}


main() async {
  var tracks = await File('day13.txt').readAsLines();
//  tracks = await File('test.txt').readAsLines();
  var carts = List<Point>();
  var speeds = List<Point>();
  var turns = List<int>();

  for (int y = 0; y < tracks.length; y++) {
    for (int x = 0; x < tracks[y].length; x++) {
      var c = tracks[y][x];
      switch(c) {
        case "<":
          carts.add(Point(x, y));
          speeds.add(Point(-1, 0));
          turns.add(0);
          tracks[y] = tracks[y].replaceRange(x, x+1, '-');
          break;
        case ">":
          carts.add(Point(x, y));
          speeds.add(Point(1, 0));
          turns.add(0);
          tracks[y] = tracks[y].replaceRange(x, x+1, '-');
          break;
        case "v":
          carts.add(Point(x, y));
          speeds.add(Point(0, 1));
          turns.add(0);
          tracks[y] = tracks[y].replaceRange(x, x+1, '|');
          break;
        case "^":
          carts.add(Point(x, y));
          speeds.add(Point(0, -1));
          turns.add(0);
          tracks[y] = tracks[y].replaceRange(x, x+1, '|');
          break;
      }
    }
  }

  var t = 0;
  bool collision = false;
  while (!collision) {
    collision = advance(tracks, carts, speeds, turns);
    t += 1;
    print_tracks(tracks, carts, speeds);
  }
  carts.sort((p1, p2) => p1.x.compareTo(p2.x));
  print(carts);
}