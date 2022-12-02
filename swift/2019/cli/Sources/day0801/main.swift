import data

let d = Day08.input
let c = d.count
let layerSize = 25 * 6
let res = stride(from: 0, to: c, by: layerSize).map { (s: Int) -> String in
    let start = d.index(d.startIndex, offsetBy: s)
    let end   = d.index(start, offsetBy: layerSize, limitedBy: d.endIndex)!
    return String(d[start..<end])
}

let minimum = res.min { (a: String, b: String) -> Bool in
    return a.lazy.filter { $0 == "0" } .count < b.lazy.filter { $0 == "0" } .count
}!

var one = 0
var two = 0
for ch in minimum {
    switch ch {
    case "1":
        one += 1
        
    case "2":
        two += 1
        
    default:
        continue
    }
}
print(one * two)
