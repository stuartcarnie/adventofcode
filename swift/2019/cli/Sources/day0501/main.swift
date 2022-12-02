import data

var inp = SingleValueInput(v: 1)
var out = SingleValueOutput()
let comp = Intcode(size: 8192, inport: inp, outport: out)
comp.load(mem: Day05.input)
comp.run()

if let output = out.lastValue {
    print(output)
} else {
    print("no output")
}

