//
// Created by Stuart Carnie on 12/6/19.
//

import Foundation

extension Int {
    @usableFromInline
    internal static let zero = UInt8(ascii: "0")

    @inlinable
    public init<T: Sequence>(ascii: T) where T.Element == UInt8 {
        self = 0
        for ch in ascii {
            let v = Int(ch - Self.zero)
            self = self * 10 + v
        }
    }
    
    // returns the greatest common divisor of self and other
    public func gcd(_ other: Int) -> Int {
        var (a, b) = (Swift.max(self, other), Swift.min(self, other))
        while b != 0 {
            (a, b) = (b, a%b)
        }
        return a
    }
    
    // returns the least common multiple of self and other
    public func lcm(_ other: Int) -> Int {
        self / self.gcd(other) * other
    }
}

public extension String.StringInterpolation {
    /// Represents a single numeric radix
    enum Radix: Int {
        case binary = 2, octal = 8, decimal = 10, hex = 16
        
        /// Returns a radix's optional prefix
        var prefix: String {
             return [.binary: "0b", .octal: "0o", .hex: "0x"][self, default: ""]
        }
    }
    
    /// Return padded version of the value using a specified radix
    mutating func appendInterpolation<T: BinaryInteger>(_ value: T, radix: Radix, prefix: Bool = false, toWidth width: Int = 0) {
        if prefix {
            appendLiteral(radix.prefix)
        }

        let string = String(value, radix: radix.rawValue)
        if string.count < width {
            appendLiteral(String(repeating: "0", count: max(0, width - string.count)))
        }
        
        appendLiteral(string)
    }
}
