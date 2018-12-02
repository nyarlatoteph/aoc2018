result = 0
with open("day1.txt") as f:
    content = f.readlines()

for line in content:
    result = result + int(line)

print(result)


result = 0
results = set()
n = 0
while True:
    result += int(content[n])
    if result in results:
        break
    results.add(result)
    n = (n + 1) % 1024
    # print(result, results)

print result