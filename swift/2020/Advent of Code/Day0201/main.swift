//
//  main.swift
//  Day0201
//
//  Created by Stuart Carnie on 3/12/20.
//

import Foundation

let passwords = Day02.parsed()
print("\(passwords[0])")

let passed = passwords.filter { info -> Bool in
    let count = info.3.reduce(0) { (v, ch) -> Int in
        ch == info.2 ? v + 1 : v
    }
    // info.0 ≤ count ≤ info.1
    return case info.0...info.1 = count
}

print("\(passed.count)")
