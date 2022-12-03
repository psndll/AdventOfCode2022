//
//  aoc_2022_3.swift
//  aoc-2022
//
//  Created by Pär Sandell on 2022-12-03.
//

public func aoc_22_3() {
    
    print("\n   --- Day 3 ---")
    
    // priority
    var priority = [Character:Int]()
    for (i,char) in "abcdefghijklmnopqrstuvwxyz".enumerated() {
        priority[char] = i + 1
        let ucaseChar = Character(char.uppercased())
        priority[ucaseChar] = (i + 27)
    }
    
    if let packingList = load(file: "input/packlist") {
        
        //part one
        var myScore = [Int]()
        
        packingList.forEach() {line in
            if line != "" {
                
                var cmp1 = [Character]()
                var cmp2 = [Character]()
                let half = (line.count / 2)
                
                for i in 0..<half {
                    cmp1.append(line[i])
                    cmp2.append(line[i + half])
                }
                
                for i in 0..<half {
                    if cmp2.contains(cmp1[i]) {
                        if let prio = priority[cmp1[i]] {
                            myScore.append(prio)
                        }
                        break;
                    }
                }
            }
        }
        
        print("Part 1: sum of priorities: \(myScore.reduce(0, +))")
        
        //part two
        var myScore2 = [Int]()
        
        var pack1 = ""
        var pack2 = ""
        let groupSize = 3
        
        for (i, line) in packingList.enumerated() {
            switch i % groupSize {
            case 0: pack1 = line
            case 1: pack2 = line
            case 2:
                for ch in line {
                    if ((pack1.contains(ch)) && (pack2.contains(ch))) {
                        if let prio = priority[ch] {
                            myScore2.append(prio)
                        }
                        break;
                    }
                }
            default: print("strange result")
            }
        }
        
        print("Part 2: sum of priorities: \(myScore2.reduce(0, +))")
    }
}
