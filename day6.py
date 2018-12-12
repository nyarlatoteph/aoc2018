from aoc_tools import AoCPuzzle

p = AoCPuzzle('day6.txt')
max_distance = 10000
# p = AoCPuzzle('test.txt')
# max_distance = 32


def calc(coordinates, x, y):
    return [abs(coord[0] - x) + abs(coord[1] - y) for coord in coordinates]

region_size_2 = 0
w = 0
h = 0
coordinates = []
for coordinate in p.lines:
    (x, y) = int(coordinate.split(", ")[0]), int(coordinate.split(", ")[1])
    coordinates.append((x, y))
    w = max(w, x)
    h = max(h, y)

distances = [[0 for x in range(w+1)] for y in range(h+1)]
for x in range(w+1):
    for y in range(h+1):
        d = calc(coordinates, x, y)
        if d.count(min(d)) == 1:
            distances[y][x] = d.index(min(d))
        else:
            distances[y][x] = -1

        s = sum(d)
        if s < max_distance:
            region_size_2 += 1


infinites = set(distances[0])
infinites.update(distances[h])
for y in range(h):
    infinites.add(distances[y][0])
    infinites.add(distances[y][w])


print coordinates
print infinites
print "\n".join(["".join([chr(ord('A') + p) if p >= 0 else '.' for p in line]) for line in distances])

f = [item for sublist in distances for item in sublist]
occurances = [(o, f.count(o)) for o in set(f)]
occurances = sorted(occurances, reverse=True, key=lambda p: p[1])
print occurances

for o in occurances:
    if o[0] not in infinites:
        print chr(ord('A') + o[0])
        print f.count(o[0])
        break

print region_size_2