import Foundation
import CoreGraphics
import data

enum Move {
    case left(Int)
    case right(Int)
    case up(Int)
    case down(Int)
}

struct Point {
    let x: Int
    let y: Int

    /// Returns the Manhattan distance of the point to the origin (0, 0)
    var distance: Int { abs(x) + abs(y) }
}

struct Line {
    enum Orientation {
        case horizontal
        case vertical
    }

    let p: Point
    let length: Int
    let orientation: Orientation

    var segment: (Point, Point) {
        var p2: Point
        switch orientation {
        case .horizontal:
            p2 = Point(x: p.x + length, y: p.y)
        case .vertical:
            p2 = Point(x: p.x, y: p.y + length)
        }

        return length >= 0 ? (p, p2) : (p2, p)
    }

    func intersects(with o: Line) -> Point? {
        var vp1, vp2: Point
        var hp1, hp2: Point

        switch (self.orientation, o.orientation) {
        case (.vertical, .horizontal):
            (vp1, vp2) = self.segment
            (hp1, hp2) = o.segment

        case (.horizontal, .vertical):
            (vp1, vp2) = o.segment
            (hp1, hp2) = self.segment

        default:
            return nil
        }

        return hp1.x <= vp1.x && vp1.x <= hp2.x && vp1.y <= hp1.y && hp1.y <= vp2.y
               ? Point(x: vp1.x, y: hp1.y)
               : nil
    }
}

class Buffer {
    var pos: Point = Point(x: 0, y: 0)
    var data: [Line] = []

    func move(delta: Point) {
        pos = Point(x: pos.x + delta.x, y: pos.y + delta.y)
    }

    func add(dir: Move) {
        switch dir {
        case .right(let l):
            data.append(Line(p: pos, length: l, orientation: .horizontal))
            move(delta: Point(x: l, y: 0))
        case .left(let l):
            data.append(Line(p: pos, length: -l, orientation: .horizontal))
            move(delta: Point(x: -l, y: 0))
        case .up(let l):
            data.append(Line(p: pos, length: l, orientation: .vertical))
            move(delta: Point(x: 0, y: l))
        case .down(let l):
            data.append(Line(p: pos, length: -l, orientation: .vertical))
            move(delta: Point(x: 0, y: -l))
        }
    }

    func print() {
        for line in data {
            switch line.orientation {
            case .vertical:
                Swift.print("\(line.p.x) \(line.p.y) 0 \(line.length)")
            case .horizontal:
                Swift.print("\(line.p.x) \(line.p.y) \(line.length) 0")
            }
        }
    }
}

extension UInt8 {
    static let left = UInt8(ascii: "L")
    static let right = UInt8(ascii: "R")
    static let up = UInt8(ascii: "U")
    static let down = UInt8(ascii: "D")
}

func parse(_ data: [String]) -> [Move] {
    var moves = [Move]()

    for d in data {
        let b: [UInt8] = Array(d.utf8)
        switch b[0] {
        case .right:
            let v = Int(ascii: b[1...])
            moves.append(.right(v))

        case .left:
            let v = Int(ascii: b[1...])
            moves.append(.left(v))

        case .up:
            let v = Int(ascii: b[1...])
            moves.append(.up(v))

        case .down:
            let v = Int(ascii: b[1...])
            moves.append(.down(v))

        default:
            fatalError("unexpected value \(b[0])")
        }
    }

    return moves
}

let buf1 = Buffer()
let moves1 = parse(Day03.input[0])
for move in moves1 {
    buf1.add(dir: move)
}

let buf2 = Buffer()
let moves2 = parse(Day03.input[1])
for move in moves2 {
    buf2.add(dir: move)
}

var intersections = [Point]()
for l1 in buf1.data {
    for l2 in buf2.data {
        guard let p = l1.intersects(with: l2) else {
            continue
        }
        intersections.append(p)
    }
}

intersections.sort { $0.distance < $1.distance }
print(intersections.first!.distance)
