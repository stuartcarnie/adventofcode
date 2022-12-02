import data

let d = Day08.input
let c = d.count
let width = 25
let height = 6
let layerSize = width * height
let layers = stride(from: 0, to: c, by: layerSize).map { (s: Int) -> [UInt8] in
    let start = d.index(d.startIndex, offsetBy: s)
    let end   = d.index(start, offsetBy: layerSize, limitedBy: d.endIndex)!
    return [UInt8](d[start..<end].utf8)
}

let transparent = UInt8(ascii: "2")
var img = [UInt8](repeating: transparent, count: layerSize)

for layer in layers {
    for (i, v) in layer.enumerated() {
        if v != transparent && img[i] == transparent {
            img[i] = v
        }
    }
}

let finalImage = stride(from: 0, to: img.count, by: width).map { (s: Int) -> String in
    return String(bytes: img[s..<s+width].map({ $0 == UInt8(ascii: "0") ? 32 : UInt8(ascii: "#") }), encoding: .ascii)!
}

print(finalImage.joined(separator: "\n"))
