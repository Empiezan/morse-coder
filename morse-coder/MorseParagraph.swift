//
//  MorseParagraph.swift
//  morse-coder
//
//  Created by labuser on 9/2/18.
//  Copyright © 2018 mc. All rights reserved.
//

import Foundation

struct MorseParagraph {
    
    enum MorseError : Error {
        case CharacterNotInDictionary
    }
    
    var words : String = ""
    var morseWords : String = ""
    
    static var translationDict : [String : String] = [:]
    
    init() {

    }
    
    init (textToTranslate : String) throws {
        self.init()
        words = textToTranslate
        
        setupTranslationDict()
        
        let unicodeArr = Array(words.uppercased())
        
        let morseArr = try unicodeArr.map{ (character) -> String in
            let morseTranslation = MorseParagraph.translationDict[String(character)]
            if morseTranslation != nil {
                return morseTranslation!
            } else {
                throw MorseError.CharacterNotInDictionary
            }
        }
        
        morseWords = morseArr.reduce("", { (prev, curr) in
            if !prev.isEmpty && curr != "|" && prev.last != "|"  {
                return prev + " " + curr
            }
            else {
                return prev + curr
            }
        })
    }
    
    func setupTranslationDict() {
        if let url = Bundle.main.url(forResource: "Morse", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                MorseParagraph.translationDict = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String : String]
            } catch {
                print(error)
            }
        }
    }
    
    func getWords() -> String {
        return words
    }
    
    func getMorse() -> String {
        return morseWords
    }
}
