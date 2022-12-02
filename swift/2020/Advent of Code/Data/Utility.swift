//
//  Utility.swift
//
//  Created by Stuart Carnie on 3/12/20.
//

import Foundation

public func binarySearch<T: Comparable>(_ a: [T], key: T) -> Int? {
    var lowerBound = 0
    var upperBound = a.count
    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound - lowerBound) / 2
        if a[midIndex] == key {
            return midIndex
        } else if a[midIndex] < key {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }
    return nil
}

public func find<T: Comparable>(_ a: [T], key: T) -> Int {
    var lowerBound = 0
    var upperBound = a.count
    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound - lowerBound) / 2
        if a[midIndex] < key {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }
    return lowerBound
}

extension StringProtocol {
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
              let range = self[startIndex...].range(of: string, options: options) {
            result.append(range)
            startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

extension String {
    func ranges(ofRegex string: String, options: NSRegularExpression.Options = []) -> [Range<Index>] {
        var result: [Range<Index>] = []

        guard
            let regex = try? NSRegularExpression(pattern: String(string), options: options)
        else { return result }

        regex.enumerateMatches(in: self, options: [], range: NSRange(self.startIndex..<self.endIndex, in: self)) { (match, _, stop) in
            guard
                let match = match,
                let range = Range(match.range(at: 0), in: self)
            else { return }

            result.append(range)
        }

        return result
    }
}

public class RegEx {
    private let regex: NSRegularExpression

    public init(pattern: String, options: NSRegularExpression.Options = []) throws {
        regex = try NSRegularExpression(pattern: pattern, options: options)
    }

    public struct Match {
        public let values: [Substring?]
        public let ranges: [Range<String.Index>?]
    }

    public func numberOfMatches(in string: String, from index: String.Index? = nil) -> Int {
        let startIndex = index ?? string.startIndex
        let range = NSRange(startIndex..., in: string)
        return regex.numberOfMatches(in: string, range: range)
    }

    public func firstMatch(in string: String, from index: String.Index? = nil) -> Match? {
        let startIndex = index ?? string.startIndex
        let range = NSRange(startIndex..., in: string)
        let result = regex.firstMatch(in: string, range: range)
        return result.flatMap { map(result: $0, in: string) }
    }

    public func matches(in string: String, from index: String.Index? = nil) -> [Match] {
        let startIndex = index ?? string.startIndex
        let range = NSRange(startIndex..., in: string)
        let results = regex.matches(in: string, range: range)
        return results.map { map(result: $0, in: string) }
    }

    public func test(_ string: String) -> Bool {
        return firstMatch(in: string) != nil
    }

    func map(result: NSTextCheckingResult, in string: String) -> Match {
        let ranges = (0..<result.numberOfRanges).map { index in
            Range(result.range(at: index), in: string)
        }
        let substrings = ranges.map { $0.flatMap { string[$0] } }
        return Match(values: substrings, ranges: ranges)
    }

}

extension RegEx {
    public class Iterator: IteratorProtocol {
        let regex: RegEx
        let string: String
        var current: RegEx.Match?

        init(regex: RegEx, string: String) {
            self.regex = regex
            self.string = string
            current = regex.firstMatch(in: string)
        }

        public func next() -> RegEx.Match? {
            defer {
                current = current.flatMap {
                    let index = $0.ranges[0]?.upperBound
                    return self.regex.firstMatch(in: self.string, from: index)
                }
            }
            return current
        }
    }

    public func iterator(for string: String) -> Iterator {
        return Iterator(regex: self, string: string)
    }
}