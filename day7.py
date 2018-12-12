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


def pick_step(todo, done):
    def can_do_step(step):
        return step not in prereqs or all([c in done for c in prereqs[step]])

    n = 0
    while n < len(todo) and not can_do_step(todo[n]):
        n += 1

    if n < len(todo):
        next = todo[n]
        del todo[n]
        return next
    else:
        return None


def next_step(steps):
    next = []
    for i in steps[step]:
        if i not in done:
            next.append(i)
    return next


done = ''
todo = sorted(froms)

while len(todo) > 0:
    step = pick_step(todo, done)
    done += step

    if step not in steps:
        break # No more steps available

    todo = sorted(set(todo + next_step(steps)))


print done

workers = []
max_workers = 5
time_offset = 61


def assign_worker(workers, step):
    return workers + [(step, time_offset + ord(step) - ord('A'))]


def work(workers):
    (step, time) = min(workers, key = lambda w: w[1])
    return ([(w[0], w[1] - time) for w in workers], step, time)


done = ''
todo = sorted(froms)
total_time = 0

while len(todo) > 0 or len(workers) > 0:
    while len(todo) > 0 and len(workers) < max_workers:
        step = pick_step(todo, done)
        if step is not None and step not in done and step not in [w[0] for w in workers]:
            workers = assign_worker(workers, step)
        else:
            break

    print total_time, workers, "".join(todo), done

    (workers, step, time) = work(workers)
    workers = [w for w in workers if w[1] > 0]
    total_time += time
    done += step

    if step not in steps:
        break # No more steps available

    todo = sorted(set(todo + next_step(steps)))

print done
print total_time