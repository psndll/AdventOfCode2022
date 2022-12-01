//
//  aoc_2022_1.swift
//  aoc-2022-1
//
//  Created by Pär Sandell on 2022-12-01.
//

import Foundation

public func aoc_22_1() {
    
    if let caloriesList = loadRaw(file: "/Users/pelle/dev/git/aoc/2022/aoc-2022-1/input/calories") {
        var elfCalories = 0
        var listOfCalories = [Int]()
        
        caloriesList.forEach() { line in
            if line == "" {
                listOfCalories.append(elfCalories)
                elfCalories = 0
            }
            else {
                let calorie = Int(line) ?? 0
                elfCalories += calorie
            }
        }
        if elfCalories > 0 {
            listOfCalories.append(elfCalories)
        }
        
        if let max = listOfCalories.max() {
            print("Elf with most calories has \(max)")
        }
        
        let calorieSum = Array(listOfCalories.sorted().reversed())[0...2].reduce(0, +)
        //let sortedList = Array(listOfCalories.sorted().reversed())
        //let subarray = Array(sortedList)[0...2]
        //var calorieSum = subarray.reduce(0, +)
        
        print("three Elf with most calories has \(calorieSum)")
    }
}
