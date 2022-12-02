//
//  main.swift
//  Day0101
//
//  Created by Stuart Carnie on 3/12/20.
//

import Foundation

let sorted = Day01.input.sorted()
for j in sorted {
    let exp = 2020 - j
    if let _ = binarySearch(sorted, key: exp) {
        print("\(j * exp)")
        break
    }
}

