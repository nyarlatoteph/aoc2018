import 'dart:io';

class Point {
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

class Cart {
  Point position;
  Point speed;
  int turn;

  Cart(this.position, this.speed, this.turn);

  Point new_position(Point position, Point speed) {
    var nx = position.x + speed.x;
    var ny = position.y + speed.y;
    return Point(nx, ny);
  }

  advance() {
    this.position = new_position(position, speed);
  }

  @override
  int get hashCode => position.hashCode;

  @override
  bool operator ==(other) {
    return other is Cart && position == other.position;
  }

  @override
  String toString() {
    return "Cart $position $speed $turn";
  }
}


bool advance(tracks, List<Cart> carts) {
  for (var n = 0; n < carts.length; n++) {
    var c = tracks[carts[n].position.y][carts[n].position.x];
    if (c == '/') {
      carts[n].speed = Point(-carts[n].speed.y, -carts[n].speed.x);
    } else if (c == '\\') {
      carts[n].speed = Point(carts[n].speed.y, carts[n].speed.x);
    } else if (c == '+') {
      if (carts[n].turn == 0) {
        carts[n].speed = Point(carts[n].speed.y, -carts[n].speed.x);
      } else if (carts[n].turn == 2) {
        carts[n].speed = Point(-carts[n].speed.y, carts[n].speed.x);
      }
      carts[n].turn = (carts[n].turn + 1) % 3;
    }
    carts[n].advance();
  }
  return carts.toSet().length != carts.length;
}


print_tracks(tracks, List<Cart> carts) {
  List<String> t = List<String>.from(tracks);
  for (var n = 0; n < carts.length; n++) {
    var c = 'o';
    if (carts[n].speed.x > 0) {
      c = ">";
    } else if (carts[n].speed.x < 0) {
      c = "<";
    } else if (carts[n].speed.y > 0) {
      c = "v";
    } else if (carts[n].speed.y < 0) {
      c = "^";
    }
    t[carts[n].position.y] = t[carts[n].position.y].replaceRange(carts[n].position.x, carts[n].position.x+1, c);
  }
  for (int y = 0; y < t.length; y++) {
    print(t[y]);
  }
}


main() async {
  var tracks = await File('day13.txt').readAsLines();
//  tracks = await File('test.txt').readAsLines();
  var carts = List<Cart>();

  for (int y = 0; y < tracks.length; y++) {
    for (int x = 0; x < tracks[y].length; x++) {
      var c = tracks[y][x];
      switch(c) {
        case "<":
          carts.add(Cart(Point(x, y), Point(-1, 0), 0));
          tracks[y] = tracks[y].replaceRange(x, x+1, '-');
          break;
        case ">":
          carts.add(Cart(Point(x, y), Point(1, 0), 0));
          tracks[y] = tracks[y].replaceRange(x, x+1, '-');
          break;
        case "v":
          carts.add(Cart(Point(x, y), Point(0, 1), 0));
          tracks[y] = tracks[y].replaceRange(x, x+1, '|');
          break;
        case "^":
          carts.add(Cart(Point(x, y), Point(0, -1), 0));
          tracks[y] = tracks[y].replaceRange(x, x+1, '|');
          break;
      }
    }
  }

  print_tracks(tracks, carts);
  print(carts.length);
  while (carts.length > 1) {
    advance(tracks, carts);
//    print_tracks(tracks, carts);
    var collisions = List<Cart>.from(carts);
    collisions.sort((p1, p2) => p1.position.x.compareTo(p2.position.x));
    for (var n = 0; n < collisions.length-1; n++) {
      if (collisions[n] == collisions[n+1]) {
        collisions.removeAt(n);
        collisions.removeAt(n);
        print(collisions.length);
      }
    }
    carts = collisions;
  }
  print(carts);
}