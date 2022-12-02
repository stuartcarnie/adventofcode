import Foundation
let d = Day02.data

var pos = (0, 0)

for move in Day02.data {
    switch move {
    case .forward(let d):
        pos = (pos.0 + d, pos.1)
    case .up(let d):
        pos = (pos.0, pos.1 - d)
    case .down(let d):
        pos = (pos.0, pos.1 + d)
    }
}

print(pos.0 * pos.1)
