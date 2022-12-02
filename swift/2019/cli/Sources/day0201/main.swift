import data

func run(_ mem: inout [Int]) {
    var pc = 0

    func read() -> (Int, Int) {
        let a = mem[mem[pc]]
        pc += 1
        let b = mem[mem[pc]]
        pc += 1
        return (a, b)
    }

    while true {
        let op = mem[pc]
        pc += 1
        switch op {
        case 1: // add
            let (a, b) = read()
            mem[mem[pc]] = a + b
            pc += 1

        case 2: // mul
            let (a, b) = read()
            mem[mem[pc]] = a * b
            pc += 1

        case 99: // halt
            return

        default:
            fatalError("invalid opcode \(op)")
        }
    }
}

var mem = Day02.input
mem[1] = 12
mem[2] = 2

run(&mem)

print("\(mem[0])")

