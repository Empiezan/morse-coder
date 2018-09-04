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

class MorseCode {
    
    /// Cases where translation or audio playback might fail
    enum MorseError : Error {
        case characterNotInDictionary(missingCharacter : Character)
        case emptyDictionary
        case couldNotFindAudio
    }
    
    /// Original, untranslated text
    var words : String = ""
    /// Morse translation of words
    var morseWords : String = ""
    
    /// Audio player for morse code
    var player = AVQueuePlayer(items: [])
    
    /// English-to-Morse dictionary
    static var translationDict : [String : String] = getTranslationDict()
    static let audioFileNames : [Character : String] = [".": "di", "-": "dah" , " ": "short_gap", "|": "long_gap"]
    static var audioFiles : [String : URL] = getAudioFiles()
    
    init (textToTranslate : String) throws {
        words = textToTranslate
        
        /// concatenates the array of Morse characters into a single String
        morseWords = try MorseCode.toMorse(words: words)
    }
    
    /// Returns the English-Morse dictionary that will be used for translation
    ///
    /// - Parameters: None
    /// - Returns: The [String:String] translation dictionary
    static func getTranslationDict() -> [String : String] {
        if let url = Bundle.main.url(forResource: "Morse_International", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                return try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String : String]
            } catch {
                print(error)
            }
        }
        return [:]
    }
    
    /// Returns the Morse translation of a String
    ///
    /// - Parameters:
    ///     - words: The String to be translated
    /// - Returns: The Morse translation of the input string
    static func toMorse(words: String) throws -> String {
        if translationDict.count == 0 {
            throw MorseError.emptyDictionary
        }
        
        /// Split the string into an array of individual, uppercase characters
        let unicodeArr = Array(words.uppercased())
        
        /// Map each character to its corresponding Morse code analog
        let morseArr = try unicodeArr.map{ (character) -> String in
            guard let morseTranslation = MorseCode.translationDict[String(character)] else {
                throw MorseError.characterNotInDictionary(missingCharacter: character)
            }
            return morseTranslation
        }
        
        /// Reduce the array of Morse code characters to a single string
        let morseWords = morseArr.reduce("", { (prev, curr) in
            if !prev.isEmpty && curr != "|" && prev.last != "|"  {
                return prev + " " + curr
            }
            else {
                return prev + curr
            }
        })
        
        return morseWords
    }
    
    /// Returns a dictionary of Morse code audiofile names and their URLs
    ///
    /// - Parameters: None
    /// - Returns: The dictionary of String file names and URL keys
    static func getAudioFiles() -> [String : URL]  {
        var audioFiles : [String : URL] = [:]
        
        for fileName in audioFileNames.values {
            let url = Bundle.main.url(forResource: fileName, withExtension: "mp3")
            audioFiles[fileName] = url
        }
        
        return audioFiles
    }
    
    func playMorse() throws {
        /// A list of sounds that represent the Morse code translation
        var audioQueue : [AVPlayerItem] = []
        
        do {
            /// Map each morse code character to its corresponding sound file
            /// and add it to the audioQueue
            for sound in Array(morseWords) {
                let fileName = MorseCode.audioFileNames[sound]
                
                guard let url = MorseCode.audioFiles[fileName!] else {
                    throw MorseError.couldNotFindAudio
                }
                
                let item = AVPlayerItem(url: url)
                audioQueue.append(item)
            }
        } catch {
            /// Propagate error back to caller
            throw error
        }
        
        player = AVQueuePlayer(items: audioQueue)
        player.automaticallyWaitsToMinimizeStalling = true
        player.play()
    }
    
    func getWords() -> String {
        return words
    }
    
    func getMorse() -> String {
        return morseWords
    }
}
