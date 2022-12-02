import data

let res = Day01.input
        .map { ($0 / 3).rounded(.down) - 2 }
        .reduce(0, +)

print("\(res)")

