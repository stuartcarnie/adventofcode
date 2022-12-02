import XCTest
@testable import data

class IntcodeTests: XCTestCase {
    
    static let sumOfPrimes = [3,100,1007,100,2,7,1105,-1,87,1007,100,1,14,1105,-1,27,101,-2,100,100,101,1,101,101,1105,1,9,101,105,101,105,101,2,104,104,101,1,102,102,1,102,102,103,101,1,103,103,7,102,101,52,1106,-1,87,101,105,102,59,1005,-1,65,1,103,104,104,101,105,102,83,1,103,83,83,7,83,105,78,1106,-1,35,1101,0,1,-1,1105,1,69,4,104,99]

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var inp = SingleValueInput(v: 100000)
        var out = SingleValueOutput()
        let comp = Intcode(size: 65536, inport: inp, outport: out)
        comp.load(mem: Self.sumOfPrimes)
        comp.run()
        guard let val = out.lastValue else {
            XCTFail()
            return
        }
        XCTAssert(val == 454396537)
    }

    func testPerformanceExample() {
        var inp = SingleValueInput(v: 100000)
        var out = SingleValueOutput()
        let comp = Intcode(size: 65536, inport: inp, outport: out)
        
        self.measure {
            comp.load(mem: Self.sumOfPrimes)
            comp.run()
        }
    }

}
