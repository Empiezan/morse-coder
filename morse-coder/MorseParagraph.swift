//
//  MorseParagraph.swift
//  morse-coder
//
//  Created by labuser on 9/2/18.
//  Copyright © 2018 mc. All rights reserved.
//
// Credits
// 1. Playing a sequence of audio files (https://stackoverflow.com/questions/35844810/play-audio-file-in-a-sequence-usign-swift)
// 2. Tool used to generate morse audio files (http://www.morseresource.com/morse/makemorse.php)

import Foundation
import AVFoundation

class MorseParagraph {
    
    enum MorseError : Error {
        case characterNotInDictionary(missingCharacter : Character)
        case emptyDictionary
        case couldNotFindAudio
    }
    
    var words : String = ""
    var morseArr : [String] = []
    var morseWords : String = ""
    var player = AVQueuePlayer(items: [])
    
    static var translationDict : [String : String] = getTranslationDict()
    static let audioFileNames : [Character : String] = [".": "di", "-": "dah" , " ": "short_gap", "|": "long_gap"]
    static var audioFiles : [String : URL] = getAudioFiles()
    
    init (textToTranslate : String) throws {
        words = textToTranslate
        
        morseArr = try MorseParagraph.toMorse(words: words)
        
        morseWords = morseArr.reduce("", { (prev, curr) in
            if !prev.isEmpty && curr != "|" && prev.last != "|"  {
                return prev + " " + curr
            }
            else {
                return prev + curr
            }
        })
    }
    
    static func getTranslationDict() -> [String : String] {
        if let url = Bundle.main.url(forResource: "Morse", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                return try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String : String]
            } catch {
                print(error)
            }
        }
        return [:]
    }
    
    static func toMorse(words: String) throws -> [String] {
        if translationDict.count == 0 {
            throw MorseError.emptyDictionary
        }
        
        let unicodeArr = Array(words.uppercased())
        
        let morseArr = try unicodeArr.map{ (character) -> String in
            guard let morseTranslation = MorseParagraph.translationDict[String(character)] else {
                throw MorseError.characterNotInDictionary(missingCharacter: character)
            }
            return morseTranslation
        }
        
        return morseArr
    }
    
    static func getAudioFiles() -> [String : URL]  {
        var audioFiles : [String : URL] = [:]
        
        for fileName in audioFileNames.values {
            let url = Bundle.main.url(forResource: fileName, withExtension: "mp3")
            audioFiles[fileName] = url
        }
        
        return audioFiles
    }
    
    func playMorse() throws {
        var audioQueue : [AVPlayerItem] = []
        
        do {
            for sound in Array(morseWords) {
                let fileName = MorseParagraph.audioFileNames[sound]
                
                guard let url = MorseParagraph.audioFiles[fileName!] else {
                    throw MorseError.couldNotFindAudio
                }
                
                let item = AVPlayerItem(url: url)
                audioQueue.append(item)
            }
        } catch let error as MorseError{
            throw error
        } catch {
            print(error)
        }
        
        player = AVQueuePlayer(items: audioQueue)
        player.play()
    }
    
    func getWords() -> String {
        return words
    }
    
    func getMorse() -> String {
        return morseWords
    }
}
