//
//  aoc_2022_2.swift
//  aoc-2022-1
//
//  Created by Pär Sandell on 2022-12-02.
//

import Foundation

public func aoc_22_2() {
    
    let points = ["A X":4, "A Y":8, "A Z": 3, "B X":1, "B Y":5, "B Z": 9, "C X":7, "C Y":2, "C Z": 6]
    let game = ["A X":"A Z", "A Y":"A X", "A Z":"A Y", "B X":"B X", "B Y":"B Y", "B Z":"B Z", "C X":"C Y", "C Y":"C Z", "C Z": "C X"]
    
    if let strategyList = loadRaw(file: "/Users/pelle/dev/git/aoc/2022/aoc-2022-1/input/strategy") {
        
        //part one
        var myScore = [Int]()
        
        strategyList.forEach() {line in
            if line != "" {
                
                if let score = points[line] {
                    myScore.append(score)
                }
            }
        }
        
        print("My strategy score will be \(myScore.reduce(0, +))")
        
        //part two
        var myScore2 = [Int]()
        
        strategyList.forEach() {line in
            if let gameStrat = game[line] {
                if let score = points[gameStrat] {
                    myScore2.append(score)
                }
            }
        }
        
        print("My strategy score will be \(myScore2.reduce(0, +))")
    }
}
