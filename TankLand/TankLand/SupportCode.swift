//
//  SupportCode.swift
//  TankLand
//
//  Created by David Gerard on 4/7/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

//Helper functions
func splitStringIntoParts(expression: String) -> [String] {
    return expression.split{$0 == " "}.map { String($0) }
}

func splitStringIntoLines(expression: String) -> [String] {
    return expression.split{$0 == "\n"}.map { String($0) }
}

//Functions to perform actual i/o from filesystem
func readTextFile(_ path: String) -> (message: String?, fileText: String?) {
    let text: String
    do {
        text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
    } catch {
        return ("\(error)", nil)
    }
    return (nil, text)
}

func writeTextFile(_ path: String, data: String) -> String? {
    let url = NSURL.fileURL(withPath: path)
    do {
        try data.write(to: url, atomically: true, encoding: String.Encoding.utf8)
    } catch {
        return "Failed writing to URL: \(url), Error: " + error.localizedDescription
    }
    return nil
}

//Formatting functions
func fitD(_ d: Date, _ size: Int, right: Bool = false) -> String {
    let df = DateFormatter()
    df.dateFormat = "MM-dd-yyyy"
    let dAsString = df.string(from: d)
    return fit(dAsString, size, right: right)
}

func fitI(_ i: Int, _ size: Int, right: Bool = true) -> String {
    let iAsString = "\(i)"
    let newLength = iAsString.count
    return fit(iAsString, newLength > size ? newLength : size, right: right)
}

func fit(_ s: String, _ size: Int, right: Bool = false) -> String {
    var result = ""
    let sSize = s.count
    if sSize == size {return s}
    var count = 0
    if size < sSize {
        for c in s {
            if count < size {result.append(c)}
            count += 1
        }
        return result
    }
    result = s
    var addon = ""
    let num = size - sSize
    for _ in 0..<num {addon.append(" ")}
    if right {return result + addon} 
    return addon + result
}

func getRandomInt(range: Int) -> Int {   //goes from 0-range
    return Int(arc4random_uniform(UInt32(range)))
}
