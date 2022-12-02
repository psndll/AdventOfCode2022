//
//  aoc_2022_2.swift
//  aoc-2022-1
//
//  Created by Pär Sandell on 2022-12-02.
//

import Foundation

public func aoc_22_2() {
    
    print("\n   --- Day 2 ---")
    
    // points for tool rock/X=1p, paper/Y=2p, scissor/Z=3p
    let toolPoints = ["X":1, "Y":2, "Z":3]
    
    //points for game
    let gamePoints = ["AX":3, "AY":6, "AZ": 0,
                      "BX":0, "BY":3, "BZ": 6,
                      "CX":6, "CY":0, "CZ": 3]
    
    let strategy2Move = ["AX":"Z", "AY":"X", "AZ":"Y",
                         "BX":"X", "BY":"Y", "BZ":"Z",
                         "CX":"Y", "CY":"Z", "CZ": "X"]
    
    if let strategyList = load(file: "input/strategy") {
        
        //part one
        var myScore = [Int]()
        
        strategyList.forEach() {line in
            if line != "" {
                let players = line.replacingOccurrences(of: " ", with: "")
                
                guard let toolpoint = toolPoints[String(players[1])] else {return}
                guard let score = gamePoints[players] else {return}
                
                myScore.append(toolpoint + score)
            }
        }
        
        print("My strategy score will be \(myScore.reduce(0, +))")
        
        //part two
        var myScore2 = [Int]()
        
        strategyList.forEach() {line in
            let players = line.replacingOccurrences(of: " ", with: "")
            
            guard let myMove = strategy2Move[players] else {return}
                
            let newMove = String(String(players[0]) + myMove)
            guard let toolpoint = toolPoints[String(newMove[1])] else {return}
            guard let score = gamePoints[newMove] else {return}
            
            myScore2.append(toolpoint + score)
        }
        
        print("My strategy score will be \(myScore2.reduce(0, +))")
    }
}
