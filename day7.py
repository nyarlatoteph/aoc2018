from aoc_tools import AoCPuzzle

r = 'Step (\w+) must be finished before step (\w+) can begin.'
p = AoCPuzzle('day7.txt', r)
# p = AoCPuzzle('day7_2.txt', r)
# p = AoCPuzzle('test.txt', r)

steps = dict()
prereqs = dict()
froms = set([m.groups()[0] for m in p.matchers])

for m in p.matchers:
    (f, t) = m.groups()[0], m.groups()[1]
    if f not in steps:
        steps[f] = [t]
    else:
        steps[f].append(t)

    if t not in prereqs:
        prereqs[t] = [f]
    else:
        prereqs[t].append(f)

    if t in froms:
        froms.remove(t)

print steps
print prereqs

def can_do_step(n):
    return n not in prereqs or all([c in done for c in prereqs[n]])


done = ''
todo = froms

while len(todo) > 0:
    todo = sorted(set(todo))
    print done, "".join(todo)
    n = 0
    while n < len(todo) and not can_do_step(todo[n]):
        n += 1

    now = todo[n]
    del todo[n]
    done += now

    if now not in steps:
        break # No more steps available

    for i in steps[now]:
        if i not in done:
            todo.append(i)


print done

workers = [0, 0, 0, 0, 0]
