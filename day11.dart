import 'package:collection/collection.dart';

int gridSize = 300;

int power(int serialNumber, int x, int y) {
  var rackId = x + 10;
  var power = rackId * (rackId * y + serialNumber);
  if (power < 100) {
    return -5;
  } else {
    var powerString = "$power";
    return int.parse(powerString.substring(powerString.length-3, powerString.length-2)) - 5;
  }
}

List<int> maxpower(int serialNumber, int size) {
  var result = null;
  for (var x = 0; x < gridSize-size; x++) {
    for (var y = 0; y < gridSize-size; y++) {
      var totalpower = 0;
      for (var xx = 0; xx < size; xx++) {
        for (var yy = 0; yy < size; yy++) {
          totalpower += power(serialNumber, x + xx, y + yy);
        }
      }
      if (result == null || totalpower > result[2]) {
        result = [x, y, totalpower];
      }
    }
  }
  return result;
}

main() {
  assert(power(8, 3, 5) == 4);
  assert(power(57, 122, 79) == -5);
  assert(power(39, 217, 196) == 0);
  assert(power(71, 101, 153) == 4);

  assert(ListEquality().equals(maxpower(18, 3), [33, 45, 29]));
  assert(ListEquality().equals(maxpower(42, 3), [21, 61, 30]));
  assert(ListEquality().equals(maxpower(18, 16), [90, 269, 113]));
  assert(ListEquality().equals(maxpower(42, 12), [232, 251, 119]));

  var serialNumber = 8561;
  print(maxpower(serialNumber, 3));
  var maxx = null;
  for (var s = 1; s < gridSize; s++) {
    var m = maxpower(serialNumber, s);
    print("size: $s, maxpower: $m");
    if (maxx == null || m[2] > maxx[2]) {
      maxx = m;
    }
  }
  print(maxx);
}