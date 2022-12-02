//
//  main.swift
//  Day0102
//
//  Created by Stuart Carnie on 3/12/20.
//

import Foundation

let sorted = Day01.input.sorted()

outer:
for (ji, jv) in sorted.enumerated() {
    let max1 = 2020 - jv - 1
    var pos = find(sorted, key: max1)
    if pos != sorted.endIndex && sorted[pos] < max1 {
        pos += 1
    }
    for (ki, kv) in sorted[..<pos].enumerated() {
        if ki == ji { continue }
        let max2 = 2020 - jv - kv
        if let _ = binarySearch(sorted, key: max2) {
            print("\(jv * kv * max2)")
            break outer
        }
    }
}
