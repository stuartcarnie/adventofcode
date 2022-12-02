import data

func fuel(v: Double) -> Double {
    var n = v
    var f: Double = 0
    while n > 8 {
        n /= 3
        n.round(.down)
        n -= 2
        f += n
    }
    return f
}

let res = Day01.input
        .map(fuel)
        .reduce(0, +)

print("\(res)")

