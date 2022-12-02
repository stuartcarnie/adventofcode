import data
import Foundation
import CoreGraphics

class Hull {
    enum Dir {
        case up, right, down, left
        
        var delta: CGVector {
            switch self {
            case .up:
                return CGVector(dx: 0, dy: 1)
            case .left:
                return CGVector(dx: -1, dy: 0)
            case .down:
                return CGVector(dx: 0, dy: -1)
            case .right:
                return CGVector(dx: 1, dy: 0)
            }
        }
        
        var rotatedRight: Dir {
            switch self {
            case .up:
                return .right
            case .right:
                return .down
            case .down:
                return .left
            case .left:
                return .up
            }
        }
        
        var rotatedLeft: Dir {
            switch self {
            case .up:
                return .left
            case .left:
                return .down
            case .down:
                return .right
            case .right:
                return .up
            }
        }
    }
    
    var state: [CGPoint: (col: Int, count: Int)] = [:]
    var pos: CGPoint = .zero
    var dir: Dir = .up
    
    // write buffer
    var write: Int?
    
    subscript(index: CGPoint) -> Int? {
        get {
            guard let v = state[index] else { return nil }
            return v.col
        }
        
        set(newColor) {
            guard let col = newColor else { return }
            state[index] = (col: col, count: 0)
        }
    }
}

extension Hull: InputPort {
    func read() -> Int? {
        if let v = state[pos] {
            return v.col
        }
        return 0
    }
}

extension Hull: OutputPort {
    func write(_ d: Int) {
        if let last = write {
            write = nil
            var val = state[pos] ?? (col: 0, count: 0)
            val.col = last
            val.count += 1
            state[pos] = val
            if d == 0 {
                dir = dir.rotatedLeft
            } else {
                dir = dir.rotatedRight
            }
            pos += dir.delta
        } else {
            write = d
        }
    }
}

var hull = Hull()
let comp = Intcode(size: 8192, inport: hull, outport: hull)
comp.load(mem: Day11.input)
//let dis = comp.disassemble(from: 0, count: Day11.input.count)
//for i in dis {
//    print(i)
//}
comp.run()

// the count is the number of panels that were painted at least once
print(hull.state.count)

var minX: CGFloat = .infinity
var maxX: CGFloat = .zero
var minY: CGFloat = .infinity
var maxY: CGFloat = .zero

for i in hull.state {
    minX = min(minX, i.key.x)
    maxX = max(maxX, i.key.x)
    minY = min(minY, i.key.y)
    maxY = max(maxY, i.key.y)
}

let gi = GridImage(minX: minX, maxX: maxX, minY: minY, maxY: maxY, blockSize: 32)
for i in hull.state {
    gi.block(p: i.key, color: i.value.col == 0 ? .black : .white)
}
gi.write(to: URL(fileURLWithPath: "day-11.png"))

