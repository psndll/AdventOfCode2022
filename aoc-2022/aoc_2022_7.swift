//
//  aoc_2022_7.swift
//  aoc-2022
//
//  Created by Pär Sandell on 2022-12-07.
//

import Foundation

public class Node {
    var name: String
    var size: Int
    private(set) var children: [Node]
    private(set) var parent: Node?
    
    init(name: String, size: Int = 0, children: [Node] = [Node]()) {
        self.name = name
        self.size = size
        self.children = children
    }
    
    var count: Int {
        1 + children.reduce(0) {$0 + $1.count}
    }
    
    var treeSize: Int {
        self.size + children.reduce(0) {$0 + $1.treeSize}
    }
    
    var part1: [Int64] {
        if self.size == 0 {
            if self.treeSize <= 100000 {
                return [Int64(self.treeSize)] + children.reduce([0]) {$0 + $1.part1}
            }
            else {
                return children.reduce([0]) {$0 + $1.part1}
            }
        }
        
        return [0]
    }

    
    func findSize(min: Int) -> [Int] {
        var result = [Int]()
        
        if self.size == 0 {
            //subdir has 0 file size
            let mySize = self.treeSize
            
            if mySize >= min {
                result.append(mySize)
                
                for child in children {
                    result += child.findSize(min: min)
                }
                
                return result
            }
        }
        
        return result
    }
    
    func add(child: Node) {
        child.parent = self
        children.append(child)
    }
    
    func findDeep(_ name: String) -> Node? {
        if self.name == name {
            return self
        }
        
        for child in children {
            if let match = child.findDeep(name) {
                return match
            }
        }
        
        return nil
    }
    
    func getSubdir(_ name: String) -> Node? {
        for child in children {
            if child.name == name {
                return child
            }
        }
        
        return nil
    }
}



public func aoc_22_7() {
        
    print("\n   --- Day 7 ---")
    
    // file system tree
    let root = Node(name: "root")
        
    if let fsBrowse = load(file: "input/fs_commands") {
        
        //part one
        var currentNode = root
        // search for container list
        for line in fsBrowse {
            if line != "" {
                if line.starts(with: "$ ") {
                    let command = line.dropFirst(2)
                    
                    if command.starts(with: "ls") {
                        continue
                    }
                    else {
                        let instr = command.components(separatedBy: CharacterSet.whitespaces)
                        
                        switch(instr[0], instr[1]) {
                        case ("cd", "/"): currentNode = root
                        case ("cd", ".."): if let myP = currentNode.parent { currentNode = myP }
                        case ("cd", let dirName): if let dirNode = currentNode.getSubdir(dirName) { currentNode = dirNode }
                        default: print("error reading command")
                        }
                    }
                }
                else {
                    let resp = line.components(separatedBy: CharacterSet.whitespaces)
                    
                    if resp.count == 2 {
                        switch (resp[0], resp[1]) {
                        case ("dir", let dirName):
                            let subdir = Node(name: dirName)
                            currentNode.add(child: subdir)
                        case (let size, let fileName):
                            let filesize = Int(size) ?? 0
                            let file = Node(name: fileName,size: filesize)
                            currentNode.add(child: file)
                        default: print("error unhandled resp")
                        }
                    }
                }
            }
        }
        
                
        print("Part 1: sum of search \(root.part1.reduce(0, +))")

        //part two
        let freeSpace = 70000000 - root.treeSize
        let result = root.findSize(min: 30000000 - freeSpace).min()
        
        print("Part 2: free : \(result!)")
    }
}

