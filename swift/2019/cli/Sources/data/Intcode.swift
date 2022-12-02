//
//  Intcode.swift
//  data
//
//  Created by Stuart Carnie on 12/22/19.
//

import Foundation

// MARK: - Interpreter

final public class Intcode {
    // MARK: - Registers
    var pc: Int = 0
    var bp: Int = 0 // Base pointer for relative addressings
    
    // MARK: - Memory
    public var mem: [Int]
    
    // MARK: - I/O
    private var inport: InputPort
    private var outport: OutputPort
    
    public enum State {
        case interrupted
        case halted
        case invalidInstruction(pc: Int, word: Int)
    }

    enum Mode: Int {
        case indirect = 0, immediate = 1, relative = 2
        
        static let allModes: Set        = [Mode.indirect, .immediate, .relative]
        static let immediateModes: Set  = [Mode.immediate]
        static let indirectModes: Set   = [Mode.indirect]
        static let indirectWriteModes: Set   = [Mode.indirect, .relative]
    }
    
    enum Opcode: Int, CustomStringConvertible {
        // Arithmetic instructions
        case add = 1, mul
        
        // I/O instructions
        case input = 3, output
        
        // Jump
        case jeq = 5, jne
        
        // Comparison
        case cmple = 7, test
        
        // Registers
        case addbp = 9
        
        // Processor control
        case halt = 99
        
        /// arity returns the number of required parameters for the opcode
        var arity: Int {
            switch self {
            case .add, .mul, .cmple, .test:
                return 3
            case .jeq, .jne:
                return 2
            case .input, .output, .addbp:
                return 1
            case .halt:
                return 0
            }
        }
        
        var description: String {
            switch self {
            case .add:
                return "add"
            case .mul:
                return "mul"
            case .input:
                return "in"
            case .output:
                return "out"
            case .jeq:
                return "jeq"
            case .jne:
                return "jne"
            case .cmple:
                return "cmple"
            case .test:
                return "test"
            case .addbp:
                return "addbp"
            case .halt:
                return "halt"
            }
        }
    }
    
    public init(size: Int, inport: InputPort, outport: OutputPort) {
        self.mem = [Int](repeating: 0, count: size)
        self.inport = inport
        self.outport = outport
    }
    
    public func load(mem: [Int]) {
        self.mem[0..<mem.count] = mem[0..<mem.count]
    }
    
    @discardableResult
    func check(_ mode: Mode?, for s: Set<Mode>) -> Mode {
        guard let mode = mode else { fatalError("invalid addressing mode") }
        guard s.contains(mode) else { fatalError("unsupported addressing mode: \(mode)") }
        return mode
    }
    
    func check(_ modes:(Mode?, Mode?), for s: (Set<Mode>, Set<Mode>)) -> (Mode, Mode) {
        (check(modes.0, for: s.0), check(modes.1, for: s.1))
    }
    
    func check(_ modes:(Mode?, Mode?, Mode?), for s: (Set<Mode>, Set<Mode>, Set<Mode>)) -> (Mode, Mode, Mode) {
        (check(modes.0, for: s.0), check(modes.1, for: s.1), check(modes.2, for: s.2))
    }

    func readNext() -> Int {
        let v = mem[pc]
        pc+=1
        return v
    }
    
    func write(_ v: Int, addr: Int, mode: Mode) {
        switch mode {
        case .immediate:
            fatalError()
            
        case .indirect:
            mem[addr] = v

        case .relative:
            mem[bp + addr] = v
        }
    }

    func read(_ addr: Int, mode: Mode) -> Int {
        switch mode {
        case .immediate:
            return addr
            
        case .indirect:
            return mem[addr]
            
        case .relative:
            return mem[bp + addr]
        }
    }
    
    @discardableResult
    public func run() -> State {
        while true {
            let word = readNext()
            
            let modes = (
                a0: Mode(rawValue: (word / 100) % 10),
                a1: Mode(rawValue: (word / 1000) % 10),
                a2: Mode(rawValue: (word / 10000) % 10)
            )
            
            switch Opcode(rawValue: word % 100) {
            
            // MARK: Arithmetic instructions
            case .add:
                let (am0, am1, am2) = check(modes, for: (Mode.allModes, Mode.allModes, Mode.indirectWriteModes))
                let (a0, a1, a2) = (readNext(), readNext(), readNext())
                let (v0, v1) = (read(a0, mode: am0), read(a1, mode: am1))
                write(v0+v1, addr: a2, mode: am2)
                
            case .mul:
                let (am0, am1, am2) = check(modes, for: (Mode.allModes, Mode.allModes, Mode.indirectWriteModes))
                let (a0, a1, a2) = (readNext(), readNext(), readNext())
                let (v0, v1) = (read(a0, mode: am0), read(a1, mode: am1))
                write(v0*v1, addr: a2, mode: am2)
                
            case .jeq:
                let (am0, am1) = check((modes.a0, modes.a1), for: (Mode.allModes, Mode.allModes))
                let (a0, a1) = (readNext(), readNext())
                let (v0, v1) = (read(a0, mode: am0), read(a1, mode: am1))
                if v0 != 0 {
                    pc = v1
                }
                
            case .jne:
                let (am0, am1) = check((modes.a0, modes.a1), for: (Mode.allModes, Mode.allModes))
                let (a0, a1) = (readNext(), readNext())
                let (v0, v1) = (read(a0, mode: am0), read(a1, mode: am1))
                if v0 == 0 {
                    pc = v1
                }

            // MARK: Comparison
            case .cmple:
                let (am0, am1, am2) = check(modes, for: (Mode.allModes, Mode.allModes, Mode.indirectWriteModes))
                let (a0, a1, a2) = (readNext(), readNext(), readNext())
                let (v0, v1) = (read(a0, mode: am0), read(a1, mode: am1))
                write(v0 < v1 ? 1 : 0, addr: a2, mode: am2)

            case .test:
                let (am0, am1, am2) = check(modes, for: (Mode.allModes, Mode.allModes, Mode.indirectWriteModes))
                let (a0, a1, a2) = (readNext(), readNext(), readNext())
                let (v0, v1) = (read(a0, mode: am0), read(a1, mode: am1))
                write(v0 == v1 ? 1 : 0, addr: a2, mode: am2)
            
            // MARK: Registers
            case .addbp:
                let am0 = check(modes.a0, for: Mode.allModes)
                let a0  = readNext()
                let v0  = read(a0, mode: am0)
                bp += v0
                
            // MARK: I/O instructions
            case .input:
                let am0 = check(modes.a0, for: Mode.indirectWriteModes)
                let a0 = readNext()
                guard let v0 = inport.read() else { fatalError("missing input") }
                write(v0, addr: a0, mode: am0)
                
            case .output:
                let am0 = check(modes.a0, for: Mode.allModes)
                let a0 = readNext()
                let v0 = read(a0, mode: am0)
                outport.write(v0)

            // MARK: Processor control instructions
            case .halt:
                return .halted
                
            default:
                return .invalidInstruction(pc: pc-1, word: word)
            }
        }
    }
}

// MARK: - Disassembly

public extension Intcode {
    struct DisassembledInstruction: CustomStringConvertible {
        var address: Int = 0
        var opcode: Opcode? = nil
        var val: Int? = nil
        
        var p0: DisassembledParameter? = nil
        var p1: DisassembledParameter? = nil
        var p2: DisassembledParameter? = nil

        public var description: String {
            if let opcode = opcode {
                switch opcode.arity {
                case 3:
                    return "\(address, radix: .decimal, toWidth: 3): \(opcode) \(p0!), \(p1!), \(p2!)"
                case 2:
                    return "\(address, radix: .decimal, toWidth: 3): \(opcode) \(p0!), \(p1!)"
                case 1:
                    return "\(address, radix: .decimal, toWidth: 3): \(opcode) \(p0!)"
                default:
                    return "\(address, radix: .decimal, toWidth: 3): \(opcode)"
                }
            }
            
            return "\(address, radix: .decimal, toWidth: 3): ???"
        }
    }
    
    enum DisassembledParameter: CustomStringConvertible {
        case indirect(Int)
        case immediate(Int)
        case relative(Int)
        
        init(mode: Mode, v: Int) {
            switch mode {
            case .immediate:
                self = .immediate(v)
                
            case .indirect:
                self = .indirect(v)
                
            case .relative:
                self = .relative(v)
            }
        }
        
        public var description: String {
            switch self {
            case .immediate(let a):
                return "#\(a, radix: .decimal, toWidth: 3)"
                    
            case .indirect(let a):
                return "[\(a, radix: .decimal, toWidth: 3)]"
                
            case .relative(let a):
                if a < 0 {
                    return "[bp - \(abs(a), radix: .decimal, toWidth: 3)]"
                }
                return "[bp + \(a, radix: .decimal, toWidth: 3)]"
            }
        }
    }
    
    func disassemble(from addr: Int, count: Int) -> [DisassembledInstruction] {
        var ins = [DisassembledInstruction]()
        var pc = addr
        
        func read() -> Int {
            let v = mem[pc]
            pc += 1
            return v
        }
        
        let end = min(count, mem.count)
        while pc < end {
            let ipc  = pc
            let word = read()
            
            let modes = (
                a0: Mode(rawValue: (word / 100) % 10),
                a1: Mode(rawValue: (word / 1000) % 10),
                a2: Mode(rawValue: (word / 10000) % 10)
            )
            
            guard let opcode = Opcode(rawValue: word % 100) else {
                ins.append(DisassembledInstruction(address: ipc, val: word))
                continue
            }
            
            switch opcode.arity {
            case 3:
                let (pm0, pm1, pm2) = (check(modes.a0, for: Mode.allModes), check(modes.a1, for: Mode.allModes), check(modes.a2, for: Mode.allModes))
                let (a0, a1, a2) = (read(), read(), read())
                ins.append(DisassembledInstruction(address: ipc, opcode: opcode, p0: DisassembledParameter(mode: pm0, v: a0), p1: DisassembledParameter(mode: pm1, v: a1), p2: DisassembledParameter(mode: pm2, v: a2)))
                
            case 2:
                let (pm0, pm1) = (check(modes.a0, for: Mode.allModes), check(modes.a1, for: Mode.allModes))
                let (a0, a1) = (read(), read())
                ins.append(DisassembledInstruction(address: ipc, opcode: opcode, p0: DisassembledParameter(mode: pm0, v: a0), p1: DisassembledParameter(mode: pm1, v: a1)))

            case 1:
                let pm0 = check(modes.a0, for: Mode.allModes)
                let a0  = read()
                ins.append(DisassembledInstruction(address: ipc, opcode: opcode, p0: DisassembledParameter(mode: pm0, v: a0)))
                
            default:
                ins.append(DisassembledInstruction(address: ipc, opcode: opcode))
            }
            
        }
        
        return ins
    }
}
