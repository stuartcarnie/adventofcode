//
//  main.swift
//  Day0301
//
//  Created by Stuart Carnie on 4/12/20.
//

import Foundation

func findTreeCount(dx: Int, dy: Int) -> Int {
    var (x, y) = (0, 0)
    var treeCount = 0

    while y < Day03.height {
        treeCount += Day03[x, y].rank
        x += dx
        y += dy
    }
    
    return treeCount
}

print("\(findTreeCount(dx: 3, dy: 1))")
