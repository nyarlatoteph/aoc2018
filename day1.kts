package alberda.aoc2018
import java.io.File;

var content = File("day1.txt").readLines()
println(content.fold(0, { result: Int, line: String ->
    result + line.toInt()
}))

var result = 0
var results = hashSetOf<Int>()
var n = 0
while (true) {
    results.add(result)
    result += content[n].toInt()
    if (result in results) {
        break
    }
    n = (n + 1) % 1024
}

println(result)