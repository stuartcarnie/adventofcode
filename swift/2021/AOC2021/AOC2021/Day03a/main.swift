import Foundation

var counters = [Int](repeating: 0, count: 12)

for row in Day03.data {
    for (i, v) in row.enumerated() {
        if v == "1" {
            counters[i] += 1
        }
    }
}

let total = Day03.data.count / 2
var s1 = ""
var s2 = ""
for v in counters {
    s1.append(v > total ? "1" : "0")
    s2.append(v < total ? "1" : "0")
}

let gamma = UInt(s1, radix: 2)!
let epsilon = UInt(s2, radix: 2)!
print(gamma * epsilon)

