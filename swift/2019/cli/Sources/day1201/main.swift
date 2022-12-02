import simd
import Foundation

struct Input {
    static let ex1 = """
<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>
"""
    static let puzzle = """
<x=3, y=-6, z=6>
<x=10, y=7, z=-9>
<x=-3, y=-7, z=9>
<x=-8, y=0, z=4>
"""
}

struct Body: CustomStringConvertible {
    var position: SIMD3<Double>
    var velocity: SIMD3<Double>
    
    var potentialEnergy: Double { abs(position).sum() }
    var kineticEnergy: Double   { abs(velocity).sum() }
    var energy: Double          { potentialEnergy * kineticEnergy }
    
    var description: String {
        "pos=<\(position)>, vel=<\(velocity)>"
    }
}

struct Simulation: CustomStringConvertible {
    var bodies: [Body]
    
    init(bodies: [Body]) {
        self.bodies = bodies
    }
    
    mutating func step() {
        for i in 0..<bodies.count {
            var a = bodies[i]
            for j in i+1..<bodies.count {
                var b = bodies[j]
                
                // determine difference in position of b with respect to a
                let diff = a.position + b.position
                
                // determine which elements are equal
                let equal = diff .== 0
                
                // determine which elements of a < b
                let lessThan = diff .< 0
                
                let chg = SIMD3<Double>(x: -1, y: -1, z: -1)
                    .replacing(with: 1, where: lessThan) // increase velocity of a when less
                    .replacing(with: 0, where: equal)    // velocity remains unchanged when equal
                a.velocity = a.velocity + chg
                b.velocity = b.velocity - chg

                bodies[j] = b
            }
            a.position += a.velocity
            bodies[i] = a
        }
    }
    
    var energy: Double {
        bodies.reduce(0) { $0 + $1.energy }
    }
    
    var description: String {
        bodies.map(String.init).joined(separator: "\n")
    }
}

func parse(_ s: String) -> [Body] {
    var bodies = [Body]()
    
    let regex = try! NSRegularExpression(pattern: #"(?<x>x=-?\d+),\s*(?<y>y=-?\d+),\s*(?<z>z=-?\d+)"#, options: [])
    
    let lines = s.components(separatedBy: .newlines)
    for line in lines {
        let range = NSRange(line.startIndex..<line.endIndex, in: line)
        guard let match = regex.firstMatch(in: line, options: [], range: range) else { continue }
        var scalars = [Double]()
        
        for c in ["x", "y", "z"] {
            let nr = match.range(withName: c)
            if nr.location != NSNotFound, let r = Range(nr, in: line) {
                let s = line[r]
                let parts = s.split(separator: "=")
                scalars.append(Double(parts[1])!)
            }
        }
        
        bodies.append(Body(position: SIMD3(scalars), velocity: [0, 0, 0]))
    }
    
    return bodies
}

let bodies = parse(Input.puzzle)
var sim = Simulation(bodies: bodies)

for _ in 0..<1000 {
    sim.step()
}

print("energy: \(sim.energy)")

exit(0)
