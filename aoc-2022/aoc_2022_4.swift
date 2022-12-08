//
//  aoc_2022_4.swift
//  aoc-2022
//
//  Created by Pär Sandell on 2022-12-04.
//

import Foundation


public func aoc_22_4() {
    
    print("\n   --- Day 4 ---")
    
    // section
    let fieldPattern = /(?<aMin>\d+)-(?<aMax>\d+),(?<bMin>\d+)-(?<bMax>\d+)/
    let point = 1
    if let sectionList = load(file: "input/sections") {
        
        //part one
        var myScore = [Int]()
        
        sectionList.forEach() {line in
            if line != "" {
                if let matcher = try? fieldPattern.firstMatch(in: line) {
                    
                    //convert strings to integers
                    let aStart = Int(matcher.aMin) ?? 0
                    let aEnd   = Int(matcher.aMax) ?? 0
                    let bStart = Int(matcher.bMin) ?? 0
                    let bEnd   = Int(matcher.bMax) ?? 0
                    
                    if ((aStart >= bStart) && (aEnd <= bEnd)) ||
                       ((bStart >= aStart) && (bEnd <= aEnd)) {
                        myScore.append(point)
                    }
                }
            }
        }
        
        print("Part 1: sum of priorities: \(myScore.reduce(0, +))")
        
        //part two
        var myScore2 = [Int]()
        
        sectionList.forEach() {line in
            if line != "" {
                if let matcher = try? fieldPattern.firstMatch(in: line) {
                    
                    let aStart = Int(matcher.aMin) ?? 0
                    let aEnd   = Int(matcher.aMax) ?? 0
                    let bStart = Int(matcher.bMin) ?? 0
                    let bEnd   = Int(matcher.bMax) ?? 0
                    
                    if ((aStart >= bStart) && (aStart <= bEnd)) ||
                       ((aEnd >= bStart) && (aEnd <= bEnd))     ||
                       ((bStart >= aStart) && (bStart <= aEnd)) ||
                       ((bEnd >= aStart) && (bEnd <= aEnd)) {
                        myScore2.append(point)
                    }
                }
            }
        }
        
        print("Part 2: sum of priorities: \(myScore2.reduce(0, +))")
    }
}
