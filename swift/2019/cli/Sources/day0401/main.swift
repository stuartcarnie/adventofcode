import Foundation

struct Num {
    var d: [UInt8]
    
    init(s: String) {
        precondition(s.count == 6)
        d = [UInt8](s.utf8)
    }
    
    var isValid: Bool {
        var iter = d.makeIterator()
        var prev = iter.next()!
        var adjacent: Bool = false
        while let next = iter.next() {
            if prev > next {
                return false
            }
            adjacent = adjacent || (prev == next)
            prev = next
        }
        return adjacent
    }
    
    mutating func adjust() {
        if isValid {
            return
        }
        
        var iter = d.enumerated().makeIterator()
        var (_, prev) = iter.next()!
        while let (i, next) = iter.next() {
            if next < prev {
                fill(from: i, ch: prev)
                break
            }
            prev = next
        }
    }
    
    private mutating func fill(from i: Int, ch: UInt8) {
        for j in i..<d.count {
            d[j] = ch
        }
    }
    
    private static let digit9 = UInt8(ascii: "9")
    
    @discardableResult
    mutating func increment() -> Bool {
        repeat {
            let li = d.endIndex-1
            if d[li] == Self.digit9 {
                // roll digits
                guard let idx = d.lastIndex(where: { $0 < Self.digit9 }) else { return false }
                d[idx] += 1
                fill(from: idx+1, ch: d[idx])
            } else {
                d[li] += 1
            }
        } while !isValid
        return true
    }
    
    func compare(with o: Num) -> ComparisonResult {
        for (l, r) in zip(d, o.d) {
            if l > r {
                return .orderedDescending
            } else if l < r {
                return .orderedAscending
            }
        }
        
        return d.count < o.d.count ? .orderedAscending : .orderedDescending
    }
    
    static func <(left: Num, right: Num) -> Bool {
        return left.compare(with: right) == .orderedAscending
    }
}

extension Num: CustomStringConvertible {
    public var description: String { String(bytes: d, encoding: .ascii)! }
}

var lo = Num(s: "240298")
lo.adjust()
var hi = Num(s: "784956")

var c = 0
while lo < hi {
    c+=1
    lo.increment()
}

print(c)
