//
//  main.swift
//  Day0302
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

var res: Int = findTreeCount(dx: 1, dy: 1)
res *= findTreeCount(dx: 3, dy: 1)
res *= findTreeCount(dx: 5, dy: 1)
res *= findTreeCount(dx: 7, dy: 1)
res *= findTreeCount(dx: 1, dy: 2)
print("\(res)")
