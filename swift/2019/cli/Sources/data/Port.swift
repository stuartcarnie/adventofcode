import Foundation

public protocol InputPort {
    func read() -> Int?
}

public protocol OutputPort {
    mutating func write(_ d: Int)
}

public struct SingleValueInput: InputPort {
    let v: Int
    
    public init(v: Int) {
        self.v = v
    }
    
    public func read() -> Int? { v }
}

public class MultiValueOutput: OutputPort {
    public var d = [Int]()
    
    public init() {}
    
    public func write(_ d: Int) {
        self.d.append(d)
    }
}

public class SingleValueOutput: OutputPort {
    var v: Int? = nil
    public var lastValue: Int? { v }
    
    public init() {}
    
    public func write(_ d: Int) {
        self.v = d
    }
}
