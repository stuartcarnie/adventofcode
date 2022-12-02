//
//  main.swift
//  Day0401
//
//  Created by Stuart Carnie on 4/12/20.
//

import Foundation

let records = Day04.records()

let regex = try! NSRegularExpression(pattern: #"(\w+):\S+"#, options: [])

let required = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])

let valid = records.map { rec -> Bool in
    var keys = [String]()
    regex.enumerateMatches(in: rec, options: [], range: NSRange(rec.startIndex..<rec.endIndex, in: rec)) { (match, _, _) in
        guard let match = match else { return }
        
        keys.append(String(rec[Range(match.range(at: 1), in: rec)!]))
    }
    
    let left = required.subtracting(keys)
    
    return left.count == 0
}
.filter { $0 }
.count

print("\(valid)")
