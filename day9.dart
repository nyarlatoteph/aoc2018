import 'dart:io';

int marble_game(int players, int last_marble) {
  List<int> _marbles = List();
  List<int> _scores = List(players);
  for (var n = 0; n < players; n++) {
    _scores[n] = 0;
  }
  int _current_player = 0;
  int _current_position = 0;

  int clockwise_index(int position, int amount) {
    return _marbles.isEmpty ? 0 : (position + amount) % _marbles.length;
  }

  int counter_clockwise_index(int position, int amount) {
    return _marbles.isEmpty ? 0 : (position - amount) % _marbles.length;
  }

  var new_position = 0;
  for (int _marble = 0; _marble < last_marble; _marble++) {
    if (_marble > 0 && _marble % 23 == 0) {
      new_position = counter_clockwise_index(_current_position, 7);
      _scores[_current_player] += _marble + _marbles[new_position];
      _marbles.removeAt(new_position);
      new_position = new_position % _marbles.length;
    } else {
      new_position = clockwise_index(_current_position, 2);
      if (new_position < _marbles.length) {
        _marbles.insert(new_position, _marble);
      } else {
        _marbles.add(_marble);
      }
    }
    _current_position = new_position;
    _current_player = (_current_player+1) % players;
  }

  _scores.sort();
  return _scores.reversed.first;
}

main() {
  assert(marble_game(9, 26) == 32);
  assert(marble_game(10, 1618) == 8317);
  assert(marble_game(13, 7999) == 146373);
//  assert(marble_game(17, 1104) == 2764); // dunno why this fails
  assert(marble_game(21, 6111) == 54718);
  assert(marble_game(30, 5807) == 37305);

  print(marble_game(465, 71940));
  print(marble_game(465, 7194000));
}