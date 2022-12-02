import data
import CoreGraphics
import Foundation

class ArcadeCabinet {
    enum Tile: Int {
        case empty = 0
        case wall
        case block
        case paddle
        case ball
    }
    
    var display: [CGPoint: Tile] = [:]
    var score: Int = 0
    var ball: CGPoint = .zero
    var paddle: CGPoint = .zero
    
    // write buffer
    var write = [Int]()
    var a: Animator? = nil
    
    init() {}

    init(_ a: Animator) {
        self.a = a
    }
}

extension ArcadeCabinet: InputPort {
    func read() -> Int? {
        Int(ball.x - paddle.x).signum()
    }
}

extension ArcadeCabinet: OutputPort {
    func write(_ d: Int) {
        self.write.append(d)
        if self.write.count == 3 {
            let (v0, v1, v2) = (write[0], write[1], write[2])
            write.removeAll(keepingCapacity: true)
            
            if v0 == -1 && v1 == 0 {
                // update score
                self.score = v2
                return
            }
            
            let p = CGPoint(x: v0, y: v1)
            guard let t = Tile(rawValue: v2) else { fatalError("invalid tile \(v2)") }
            self.display[p] = t
            
            switch t {
            case .ball:
                ball = p
            case .paddle:
                paddle = p
            case .empty:
                // don't render a frame for empty tiles
                return
            default:
                break
            }
            
            guard let a = self.a else { return }
            a.draw { (ctx) in
                ctx.clear(CGRect(origin: .zero, size: CGSize(width: ctx.width, height: ctx.height)))
                
                ctx.scaleBy(x: 16, y: 16)
                for i in display {
                    let rect = CGRect(origin: i.key, size: CGSize(width: 1, height: 1)).insetBy(dx: 2/16, dy: 2/16)
                    switch i.value {
                    case .empty:
                        continue
                    case .ball:
                        ctx.setFillColor(red: 1, green: 0, blue: 0, alpha: 1)
                        ctx.fillEllipse(in: rect)
                        
                    case .wall:
                        ctx.setFillColor(red: 0, green: 1, blue: 0, alpha: 1)
                        ctx.fill(rect)
                        
                    case .block:
                        ctx.setFillColor(red: 1, green: 1, blue: 1, alpha: 1)
                        ctx.fill(rect)
                        
                    case .paddle:
                        ctx.setFillColor(red: 0, green: 0, blue: 1, alpha: 1)
                        ctx.fill(rect)
                    }
                }
            }
        }
    }
}

var a = Animator(width: 35*16, height: 27*16, frameRate: 1.0/30.0, url: URL(fileURLWithPath: "day13-2.mov"))
var arcade = ArcadeCabinet(a)
let comp = Intcode(size: 8192, inport: arcade, outport: arcade)
comp.load(mem: Day13.input)
comp.mem[0] = 2 // 2 quarters
comp.run()

a.complete()

print(arcade.score)
