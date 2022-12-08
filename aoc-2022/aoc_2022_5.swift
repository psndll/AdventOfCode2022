//
//  aoc_2022_5.swift
//  aoc-2022
//
//  Created by Pär Sandell on 2022-12-04.
//

import Foundation



public func aoc_22_5() {
    
    var crates = [Int:[String]]()
    
    func putCrate(_ name: String, onStack: Int, onTop: Bool) {
        var newStack = [String]()
        
        if !onTop {
            newStack.append(name)
        }
        
        if let oldStack = crates[onStack] {
            for item in oldStack {
                newStack.append(item)
            }
        }
        
        if onTop {
            newStack.append(name)
        }
        
        crates[onStack] = newStack
    }
    
    func putCrate(_ name: [String], onStack: Int) {
        var newStack = [String]()
        
        if let oldStack = crates[onStack] {
            for item in oldStack {
                newStack.append(item)
            }
        }
        
        for i in 0..<name.count {
            newStack.append(name[i])
        }
        
        crates[onStack] = newStack
    }
    
    func pullCrate(from: Int) -> String {
        var newStack = [String]()
        var crateName = ""
        
        // recreate source stack and move top item
        if let oldFromStack = crates[from] {
            if let lastName = oldFromStack.last {
                crateName = lastName
            }
            for i in 0..<(oldFromStack.count - 1) {
                newStack.append(oldFromStack[i])
            }
        }
        
        crates[from] = newStack
        
        return crateName
    }
    
    func pullCrate(_ num: Int, from: Int) -> [String] {
        var newStack = [String]()
        var crateName = [String]()
        
        // recreate source stack and move top item
        if let oldFromStack = crates[from] {
            for i in (oldFromStack.count - num)...(oldFromStack.count - 1) {
                crateName.append(oldFromStack[i])
            }
            for i in 0..<(oldFromStack.count - num) {
                newStack.append(oldFromStack[i])
            }
        }
        
        crates[from] = newStack
        return crateName
    }
    
    print("\n   --- Day 5 ---")
    
    // section
    let containerPattern = /(?<spaces>\s*)\[(?<name>[A-Z])\]/
    let movePattern = /move\s(?<count>\d+)\sfrom\s(?<source>\d+)\sto\s(?<destination>\d+)/
    
    if let cratesList = load(file: "input/crates") {
        
        //part one
        var myScore = [String]()
        
        // search for container list
        for line in cratesList {
            if line != "" {
                //print(line)
                var crateNr = 0
                var remainder = line
                while remainder.count > (remainder.filter{ $0 == " " }.count) {
                    if let matcher = try? containerPattern.firstMatch(in: remainder) {
                        let spaces = Int(matcher.spaces.count)
                        
                        switch spaces {
                            case 0...1: crateNr += 1
                            case 4...5: crateNr += 2
                            case 8...9: crateNr += 3
                            case 12...13: crateNr += 4
                            case 16...17: crateNr += 5
                            default: crateNr += 99
                        }
                        
                        putCrate(String(matcher.name), onStack: crateNr, onTop: false )
                        
                        //print("put \(matcher.name) in crate \(crateNr)")
                        remainder.removeFirst(3 + spaces)
                    }
                    else {
                        break
                    }
                }
            }
            else {
                break
            }
        }
        
                
        for line in cratesList {
            if line != "" {
                if let matcher = try? movePattern.firstMatch(in: line) {
                    let count = Int(matcher.count) ?? 0
                    let source = Int(matcher.source) ?? 0
                    let destination = Int(matcher.destination) ?? 0
                    
                    for _ in 1...count {
                        let crate = pullCrate(from: source)
                        putCrate(crate, onStack: destination, onTop: true)
                    }
                }
            }
        }
        
        for i in 1...9 {
            if let crateStack = crates[i] {
                if let crate = crateStack.last {
                    myScore.append(crate)
                }
            }
        }

        
        print("Part 1: sum of priorities: \(myScore)")
        
        //part two
        var myScore2 = [String]()
        crates = [Int:[String]]()
        
        // search for container list
        for line in cratesList {
            if line != "" {
                //print(line)
                var crateNr = 0
                var remainder = line
                while remainder.count > (remainder.filter{ $0 == " " }.count) {
                    if let matcher = try? containerPattern.firstMatch(in: remainder) {
                        let spaces = Int(matcher.spaces.count)
                        
                        switch spaces {
                            case 0...1: crateNr += 1
                            case 4...5: crateNr += 2
                            case 8...9: crateNr += 3
                            case 12...13: crateNr += 4
                            case 16...17: crateNr += 5
                            default: crateNr += 99
                        }
                        
                        putCrate(String(matcher.name), onStack: crateNr, onTop: false )
                        
                        //print("put \(matcher.name) in crate \(crateNr)")
                        remainder.removeFirst(3 + spaces)
                    }
                    else {
                        break
                    }
                }
            }
            else {
                break
            }
        }
        
        //move
        for line in cratesList {
            if line != "" {
                if let matcher = try? movePattern.firstMatch(in: line) {
                    let count = Int(matcher.count) ?? 0
                    let source = Int(matcher.source) ?? 0
                    let destination = Int(matcher.destination) ?? 0
                    
                    let crate = pullCrate(count, from: source)
                    putCrate(crate, onStack: destination)
                }
            }
        }
        
        for i in 1...9 {
            if let crateStack = crates[i] {
                if let crate = crateStack.last {
                    myScore2.append(crate)
                }
            }
        }
        
        
        print("Part 2: sum of priorities: \(myScore2)")
    }
}

