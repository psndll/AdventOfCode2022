//
//  common.swift
//  aoc-2022-1
//
//  Created by Pär Sandell on 2022-12-01.
//

import Foundation

func load(file named: String) -> [String]? {
    guard let fileUrl = Bundle.main.url(forResource: named, withExtension: "txt") else {
        return nil
    }

    guard let content = try? String(contentsOf: fileUrl, encoding: .utf8) else {
        return nil
    }
    return content.components(separatedBy: CharacterSet.newlines)
}


extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
