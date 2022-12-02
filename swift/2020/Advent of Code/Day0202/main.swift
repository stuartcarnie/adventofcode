//
//  main.swift
//  Day0202
//
//  Created by Stuart Carnie on 3/12/20.
//

import Foundation

let passwords = Day02.parsed()

let passed = passwords.filter { info -> Bool in
    let a = info.3[info.3.index(info.3.startIndex, offsetBy: info.0 - 1)] == info.2
    let b = info.3[info.3.index(info.3.startIndex, offsetBy: info.1 - 1)] == info.2
    return a != b
}

print("\(passed.count)")
