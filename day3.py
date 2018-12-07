from aoc_tools import AoCPuzzle

p = AoCPuzzle('day3.txt', "\#(\d+)\s+@\s+(\d+),(\d+):\s+(\d+)x(\d+)")

cloth_size = 1000
overlaps = 0
cloth = [[[] for x in range(cloth_size)] for y in range(cloth_size)]
ids = [i for i in range(1, len(p.matchers))]

for m in p.matchers:
    (id, x, y, w, h) = int(m.groups()[0]), int(m.groups()[1]), int(m.groups()[2]), int(m.groups()[3]), int(m.groups()[4])
    for xx in range(w):
        for yy in range(h):
            cloth[x + xx][y + yy].append(id)
            # Only count overlapping claim once
            if len(cloth[x + xx][y + yy]) == 2:
                overlaps += 1
            if len(cloth[x + xx][y + yy]) >= 2:
                for oid in cloth[x + xx][y + yy]:
                    if oid in ids:
                        ids.remove(oid)


print overlaps
assert len(ids) == 1
print ids[0]