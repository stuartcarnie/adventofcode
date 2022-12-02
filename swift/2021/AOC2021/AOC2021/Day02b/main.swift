import Foundation
let d = Day02.data

struct Sub {
    let x: Int
    let y: Int
    let aim: Int
    
    func moving(_ move: Move) -> Sub {
        switch move {
        case .forward(let d):
            let x = self.x + d
            let yd = d * aim
            return Sub(x: x, y: y + yd, aim: aim)
        case .up(let d):
            return Sub(x: x, y: y, aim: aim - d)
        case .down(let d):
            return Sub(x: x, y: y, aim: aim + d)
        }
    }
}

var sub = Sub(x: 0, y: 0, aim: 0)
for move in Day02.data {
    sub = sub.moving(move)
}

print(sub.x * sub.y)
