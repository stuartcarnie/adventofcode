import Foundation
import data

struct Edge {
    let from: String
    let to: String
}

class Tree {
    var nodes: [String: Node] = [:]
}

class Node {
    let value: String
    var parent: Node?
    var children: [Node]
    
    var level: Int {
        var l = 0
        var p = self
        while let n = p.parent {
            l += 1
            p = n
        }
        return l
    }
    
    init(_ v: String) {
        value = v
        children = []
    }
    
    func walk(_ fn: (_ n: Node) -> Void) {
        fn(self)
        
        for child in children {
            child.walk(fn)
        }
    }
}


func parse<T: Collection>(_ lines: T) -> Tree where T.Element == String {
    var t = Tree()
    
    func node(named name: String) -> Node {
        if let n = t.nodes[name] {
            return n
        }
        let n = Node(name)
        t.nodes[name] = n
        return n
    }
    
    for l in lines {
        let v = l.components(separatedBy: ")")
        if v.count != 2 {
            fatalError("unexpected edge: \(l)")
        }
        let parent  = node(named: v[0])
        let child   = node(named: v[1])
        
        parent.children.append(child)
        precondition(child.parent == nil)
        child.parent = parent
    }
    return t
}

var data = Day06.input
let tree = parse(data)

let root = tree.nodes["COM"]!
var c = 0
root.walk { (n) in
    c+=n.level
}

print(c)
