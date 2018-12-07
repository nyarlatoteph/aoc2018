package alberda.aoc2018
import java.io.File

var boxIds = File("day2.txt").readLines()

fun hasXChars(s: String, count: Int): Boolean {
    val s1Char = s.toCharArray().distinct()
    val s2Char = s.toCharArray()

    for (char: Char in s1Char) {
        if (s2Char.filter { c -> c == char }.count() == count) {
            return true
        }
    }

    return false
}

fun checksum(boxIds: List<String>): Int {
    var n2 = 0
    var n3 = 0
    for (boxId in boxIds) {
        if (hasXChars(boxId, 2)) {
            n2 += 1
        }
        if (hasXChars(boxId, 3)) {
            n3 += 1
        }
    }

    return n2*n3
}

//boxIds = arrayListOf("abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab")
println(checksum(boxIds))


for (boxId1 in boxIds) {
    for (boxId2 in boxIds) {
        if (boxId1 == boxId2) continue
        if (boxId1.zip(boxId2).count { it.first != it.second } == 1) {
            println("$boxId1, $boxId2")
        }
    }
}