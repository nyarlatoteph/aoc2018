import 'dart:io';

class Node {
  List<int> metadata;
  List<Node> children;

  Node(this.metadata, this.children);

  int valueOfEntry(int entry) {
    if (entry < children.length) {
      return children[entry].value();
    } else {
      return 0;
    }
  }

  int value() {
    int sum(int a, int b) => a + b;

    if (children.length > 0) {
      return metadata.map((entry) => valueOfEntry(entry-1)).reduce(sum);
    }
    return metadata.reduce(sum);
  }
}

Iterable<int> number_iterator(String license) {
  var r = RegExp(r"(\d+)\s*");
  return r.allMatches(license).map((m) => int.parse(m.group(0)));
}

var total = 0;

Node parseNode(Iterator<int> iterator) {
  assert(iterator.moveNext());
  var number_of_nodes = iterator.current;
  assert(iterator.moveNext());
  var metadata_entries = iterator.current;
  List<Node> nodes = List();
  for (var n = 0; n < number_of_nodes; n++) {
    nodes.add(parseNode(iterator));
  }
  List<int> metadata = List();
  for (var n = 0; n < metadata_entries; n++) {
    assert(iterator.moveNext());
    total += iterator.current;
    metadata.add(iterator.current);
  }
  return Node(metadata, nodes);
}

main() async {
  var license = await File('day8.txt').readAsString();
//  license = await File('test.txt').readAsString();
  var license_iterator = number_iterator(license).iterator;
  var tree = parseNode(license_iterator);

  print(total);
  print(tree.value());
}
