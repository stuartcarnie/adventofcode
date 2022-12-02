import simd
import Foundation
import data

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

@usableFromInline
@frozen
struct Body: CustomStringConvertible {
    var position: SIMD3<Double>
    var velocity: SIMD3<Double>
    
    var potentialEnergy: Double { abs(position).sum() }
    var kineticEnergy: Double   { abs(velocity).sum() }
    var energy: Double          { potentialEnergy * kineticEnergy }
    
    @usableFromInline
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
                let diff = a.position - b.position
                
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

var sim   = Simulation(bodies: parse(Input.puzzle))
var found = 0
var count = 0
var steps = [0, 0, 0]

var start = Date()

// finds when all velocities in each axis are zero
// and multiplies by to to account for half the orbit.
// Velocities will reach zero twice, once at beginning and
// at 50% of the elliptical orbit.
while found != 7 {
    sim.step()
    count += 1
    var res = SIMD3<Double>(repeating: 0)
    // sum the absolute values of all velocities
    for i in sim.bodies {
        res += abs(i.velocity)
    }
    
    // when the sum for a given axis == 0, all velocities for that axis are 0
    if found & 1 == 0 && res.x == 0 {
        found |= 1
        steps[0] = count * 2
    }
    
    if found & 2 == 0 && res.y == 0 {
        found |= 2
        steps[1] = count * 2
    }
    
    if found & 4 == 0 && res.z == 0 {
        found |= 4
        steps[2] = count * 2
    }
}

var end = start.distance(to: Date())
let res = steps[0].lcm(steps[1]).lcm(steps[2])
print(res)
print("\(end)s")

exit(0)
