//
//  MorseParagraph.swift
//  morse-coder
//
//  Created by labuser on 9/2/18.
//  Copyright © 2018 mc. All rights reserved.
//

import Foundation

struct MorseParagraph {
    
    var words : String = ""
    var morseWords : String = ""
    
    static var translationDict : [String : String] = [:]
    
//    var translationDict : [Unicode.Scalar : String] = ["A": ".-",
//                                                       "B": "-...",
//                                                       "C": "-..",
//                                                       "D": "-..",
//                                                       "E": ".",
//                                                       "F": "..-.",
//                                                       "G": "--.",
//                                                       "H": "....",
//                                                       "I": "..",
//                                                       "J": "-.-",
//                                                       "K": "-.-",
//                                                       "L": "-.-",
//                                                       "M": "--",
//                                                       "N": "-.",
//                                                       "O": "---",
//                                                       "P": ".--.",
//                                                       "Q": "--.-",
//                                                       "R": ".-.",
//                                                       "S": "...",
//                                                       "T": "-",
//                                                       "U": "..-",
//                                                       "V": "...-",
//                                                       "W": ".--",
//                                                       "X": "-..-",
//                                                       "Y": "-.--",
//                                                       "Z": "--..",
//                                                       " ": "|",
//                                                       "0": "-----",
//                                                       "1": ".----",
//                                                       "2": "..---",
//                                                       "3": "...--",
//                                                       "4": "....-",
//                                                       "5": ".....",
//                                                       "6": "-....",
//                                                       "7": "--...",
//                                                       "8": "---..",
//                                                       "9": "----.",
//                                                       ".": ".-.-.-",
//                                                       ",": "--..--"]
    
    init() {

    }
    
    init (textToTranslate : String) {
        self.init()
        words = textToTranslate
        
        if let url = Bundle.main.url(forResource: "Morse", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                MorseParagraph.translationDict = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String : String]
            } catch {
                print(error)
            }
        }
        
        let unicodeArr = Array(words.uppercased())
        
        let morseArr = unicodeArr.map{ MorseParagraph.translationDict[String($0)] ?? "" }
        morseWords = morseArr.reduce("", { (prev, curr) in
            if !prev.isEmpty && curr != "|" && prev.last != "|"  {
                return prev + " " + curr
            }
            else {
                return prev + curr
            }
        })
    }
    
    func getWords() -> String {
        return words
    }
    
    func getMorse() -> String {
        return morseWords
    }
}
