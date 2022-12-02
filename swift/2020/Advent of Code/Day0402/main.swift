//
//  main.swift
//  Day0402
//
//  Created by Stuart Carnie on 6/12/20.
//

import Foundation

struct Parser {
    let scan: Scanner

    init(_ input: String) {
        scan = Scanner(string: input)
        scan.charactersToBeSkipped = CharacterSet.whitespaces.union(CharacterSet(charactersIn: ":"))
    }

    func parse() -> Passport? {
        parseRecord()
    }

    private func parseRecord() -> Passport? {
        var rec = Passport()

        while !scan.isAtEnd {
            guard
                let key = scan.scanCharacters(from: .alphanumerics),
                let val = scan.scanCharacters(from: CharacterSet.whitespacesAndNewlines.inverted)
                else {
                guard
                    let sep = scan.scanCharacters(from: .newlines)
                    else {
                    fatalError("invalid input: expected newline")
                }

                if sep.count == 1 {
                    continue
                }

                return rec
            }

            switch key {
            case "byr":
                if let val = Int(val) {
                    rec.byr = val
                    continue
                }

            case "iyr":
                if let val = Int(val) {
                    rec.iyr = val
                    continue
                }

            case "eyr":
                if let val = Int(val) {
                    rec.eyr = val
                    continue
                }

            case "hgt":
                let re = try! RegEx(pattern: #"^(\d+)(cm|in)$"#, options: [])
                if let match = re.firstMatch(in: val) {
                    print("\(key): \(match.values)")
                }
                break

            case "hcl":
                break

            case "ecl":
                break

            case "pid":
                break

            case "cid":
                break

            default:
                break
            }
        }

        return nil
    }
}

struct Passport {
    enum Height {
        case cm(Int), inch(Int)
    }

    enum EyeColour: String {
        case amb, blu, brn, gry, grn, hzl, oth
    }

    var byr: Int?
    var iyr: Int?
    var eyr: Int?
    var hgt: Height?
    var hcl: String?
    var ecl: EyeColour?
    var pid: String?
}

let parser = Parser(Day04.input)
parser.parse()