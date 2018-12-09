from aoc_tools import AoCPuzzle
from datetime import datetime, time

_minute = '\[(\d+)-(\d+)-(\d+) (\d+):(\d+)\] (wakes up|falls asleep|Guard #(\d+) begins shift)'
p = AoCPuzzle('day4.txt', _minute)
events = dict()

guards = []
for m in p.matchers:
    g = m.groups()
    who = None
    (year, month, day, hour, minute, what) = int(g[0]), int(g[1]), int(g[2]), int(g[3]), int(g[4]), g[5]
    if g[5].endswith("begins shift"):
        who = int(g[6])
        guards.append(who)
    d = datetime(year, month, day, hour, minute)
    events[d] = (what, who)

nap_time = { g:{} for g in guards }
most_asleep = { g: 0 for g in guards }
active_guard = None
previous = None
for when in sorted(events.keys()):
    (what, who) = events[when]
    print when, what

    if who is not None:
        active_guard = who
    if what == "wakes up":
        sleep_time = range(previous.minute, when.minute)
        most_asleep[active_guard] += len(sleep_time)
        for _minute in sleep_time:
            if _minute in nap_time[active_guard]:
                nap_time[active_guard][_minute] += 1
            else:
                nap_time[active_guard][_minute] = 1
    elif what == "falls asleep":
        previous = when

guard = None
asleep = None
for g in guards:
    if asleep is None or most_asleep[g] >= asleep:
        asleep = most_asleep[g]
        guard = g

n = None
m = None
for minute in nap_time[guard]:
    if n is None or nap_time[guard][minute] > n:
        n = nap_time[guard][minute]
        m = minute

print nap_time
print most_asleep
print "guard %s is alseep for %s minutes, minute %s is the minute he's asleep the most" % (guard, asleep, m)

print guard * m

n = None
m = None
g = None
for guard in nap_time:
    for minute in nap_time[guard]:
        if n is None or nap_time[guard][minute] > n:
            n = nap_time[guard][minute]
            m = minute
            g = guard
print g * m

