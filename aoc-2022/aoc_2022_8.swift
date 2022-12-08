//
//  aoc_2022_8.swift
//  aoc-2022
//
//  Created by Pär Sandell on 2022-12-08.
//

import Foundation

public func visibleFromLeft(x: Int, y: Int, height: Int, treemap: [[Int]]) -> Bool {
    if x == 0 {
        return true
    }
    else {
        if height > treemap[y][x-1] {
            return visibleFromLeft(x: x - 1, y: y, height: height, treemap: treemap)
        }
        
        return false
    }
}

public func visibleFromRight(x: Int, y: Int, height: Int, treemap: [[Int]]) -> Bool {
    let row = treemap[y]
    if x >= (row.count - 1) {
        return true
    }
    else {
        
        if height > row[x+1] {
            return visibleFromRight(x: x + 1, y: y, height: height, treemap: treemap)
        }
        
        return false
    }
}

public func visibleFromAbove(x: Int, y: Int, height: Int, treemap: [[Int]]) -> Bool {
    
    if y == 0 {
        return true
    }
    else {
        let row = treemap[y - 1]
        if height > row[x] {
            return visibleFromAbove(x: x, y: y - 1, height: height, treemap: treemap)
        }
        
        return false
    }
}

public func visibleFromBelow(x: Int, y: Int, height: Int, treemap: [[Int]]) -> Bool {
    if y >= (treemap.count - 1) {
        return true
    }
    else {
        let row = treemap[y + 1]
        if height > row[x] {
            return visibleFromBelow(x: x, y: y + 1, height: height, treemap: treemap)
        }
        
        return false
    }
}

public func distanceToLeft(x: Int, y: Int, height: Int, treemap: [[Int]]) -> Int {
    if x == 0 {
        return 0
    }
    else {
        if height > treemap[y][x-1] {
            return 1 + distanceToLeft(x: x - 1, y: y, height: height, treemap: treemap)
        }
        
        return 1
    }
}

public func distanceToRight(x: Int, y: Int, height: Int, treemap: [[Int]]) -> Int {
    let row = treemap[y]
    if x >= (row.count - 1) {
        return 0
    }
    else {
        
        if height > row[x+1] {
            return 1 + distanceToRight(x: x + 1, y: y, height: height, treemap: treemap)
        }
        
        return 1
    }
}

public func distanceToTop(x: Int, y: Int, height: Int, treemap: [[Int]]) -> Int {
    
    if y == 0 {
        return 0
    }
    else {
        let row = treemap[y - 1]
        if height > row[x] {
            return 1 + distanceToTop(x: x, y: y - 1, height: height, treemap: treemap)
        }
        
        return 1
    }
}

public func distanceToBottom(x: Int, y: Int, height: Int, treemap: [[Int]]) -> Int {
    if y >= (treemap.count - 1) {
        return 0
    }
    else {
        let row = treemap[y + 1]
        if height > row[x] {
            return 1 + distanceToBottom(x: x, y: y + 1, height: height, treemap: treemap)
        }
        
        return 1
    }
}



public func aoc_22_8() {
    
    print("\n   --- Day 8 ---")
    
    //
    if let treeList = load(file: "input/treemap") {
        
        //part one
        var treeMap = [[Int]]()
        
        //create map of tree heights
        for line in treeList {
                       
            if line != "" {
                var treeRow = [Int]()
                let chars = Array(line)
                
                for x in 0..<line.count {
                    let height = Int(String(chars[x])) ?? 0
                    treeRow.append(height)
                }
                treeMap.append(treeRow)
            }
            
        }
        
        //count visibles
        var visibles = 0
        
        for (y, row) in treeMap.enumerated() {
            for (x, height) in row.enumerated() {
                
                if visibleFromLeft(x: x, y: y, height: height, treemap: treeMap)   ||
                    visibleFromRight(x: x, y: y, height: height, treemap: treeMap) ||
                    visibleFromAbove(x: x, y: y, height: height, treemap: treeMap) ||
                    visibleFromBelow(x: x, y: y, height: height, treemap: treeMap) {
                    visibles += 1
                }
            }
        }
        
        
        print("Part 1: visibles \(visibles)")
        
        //part 2
        var scenicScore = [Int]()
        
        for (y, row) in treeMap.enumerated() {
            for (x, height) in row.enumerated() {
                let scL = distanceToLeft(x: x, y: y, height: height, treemap: treeMap)
                let scR = distanceToRight(x: x, y: y, height: height, treemap: treeMap)
                let scT = distanceToTop(x: x, y: y, height: height, treemap: treeMap)
                let scB = distanceToBottom(x: x, y: y, height: height, treemap: treeMap)
                
                let scenic = scL * scR * scT * scB
                
                scenicScore.append(scenic)
            }
        }
        
        print("Part 2: max scenic score is \(scenicScore.max()!)")
        
        
    }
    
}
