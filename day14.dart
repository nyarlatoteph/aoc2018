recipes(int amount, int digits) {
  var recipes = [3, 7];
  var elf1 = 0;
  var elf2 = 1;
  for (var n = 0; recipes.length < amount + digits; n++) {
    var s = recipes[elf1] + recipes[elf2];
    if (s < 10) {
      recipes.add(s);
    } else {
      recipes.add((s / 10).toInt());
      recipes.add(s % 10);
    }
    elf1 = (elf1 + 1 + recipes[elf1]) % recipes.length;
    elf2 = (elf2 + 1 + recipes[elf2]) % recipes.length;
  }
  return recipes.sublist(amount, amount+digits).join("");
}


recipes2(String pattern) {
  var recipes = [3, 7];
  var elf1 = 0;
  var elf2 = 1;
  var foundIndex = 0;
  while (foundIndex < pattern.length-1) {
    var s = recipes[elf1] + recipes[elf2];
    if (s < 10) {
      recipes.add(s);
      foundIndex = (foundIndex < pattern.length-1 && pattern[foundIndex + 1] == s.toString()) ? foundIndex + 1 : 0;
    } else {
      recipes.add((s / 10).toInt());
      recipes.add(s % 10);
      foundIndex = (foundIndex < pattern.length-1 && pattern[foundIndex + 1] == ((s / 10).toInt()).toString()) ? foundIndex + 1 : 0;
      foundIndex = (foundIndex < pattern.length-1 && pattern[foundIndex + 1] == (s % 10).toString()) ? foundIndex + 1 : 0;
    }
    elf1 = (elf1 + 1 + recipes[elf1]) % recipes.length;
    elf2 = (elf2 + 1 + recipes[elf2]) % recipes.length;
    print("${recipes.length}, $foundIndex");
  }
  return recipes.join("").indexOf(pattern);
}


main() {
  assert(recipes(9, 10) == "5158916779");
  assert(recipes(5, 10) == "0124515891");
  assert(recipes(18, 10) == "9251071085");
  assert(recipes(2018, 10) == "5941429882");

  print(recipes(540391, 10));

  assert(recipes2("51589") == 9);
  assert(recipes2("92510") == 18);

  print(recipes2("540391"));
}