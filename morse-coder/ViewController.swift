//
//  ViewController.swift
//  morse-coder
//
//  Created by macos on 7/21/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var morseInputView: UITextView!
    @IBOutlet weak var morseOutputView: UITextView!
    
    var morseCode : MorseParagraph!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        morseOutputView.backgroundColor = UIColor.gray
        
        do {
            morseCode = try MorseParagraph(textToTranslate: "")
        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func translateButton(_ sender: Any) {
        let inputText : String = morseInputView.text
        
        DispatchQueue.global().async {
            do {
                self.morseCode = try MorseParagraph(textToTranslate: inputText)
                DispatchQueue.main.async {
                    self.morseOutputView.text = self.morseCode.getMorse()
                }
            } catch MorseParagraph.MorseError.characterNotInDictionary(missingCharacter: let char) {
                self.showAlertMessage(title: "Whoops!", message: "We couldn't translate '\(char)'")
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func playMorseCode(_ sender: Any) {
        DispatchQueue.global().async {
            do {
                try self.morseCode.playMorse()
            } catch {
                self.showAlertMessage(title: "Sorry!", message: "We couldn't play the audio right now!")
            }
        }
    }
    
    func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

