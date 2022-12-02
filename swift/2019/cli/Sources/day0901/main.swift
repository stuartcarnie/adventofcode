import data

var inp = SingleValueInput(v: 1)
var out = MultiValueOutput()
let comp = Intcode(size: 8192, inport: inp, outport: out)
comp.load(mem: Day09.input)
comp.run()

for v in out.d {
    print(v)
}

