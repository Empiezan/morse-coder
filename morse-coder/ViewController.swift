//
//  ViewController.swift
//  morse-coder
//
//  Created by macos on 7/21/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var spinner : UIActivityIndicatorView!
    
    @IBOutlet weak var morseInputView: UITextView!
    @IBOutlet weak var morseOutputView: UITextView!
    
    var morseCode : MorseCode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupSpinner()
        translateText(text: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSpinner() {
        let width : CGFloat = 50
        let height : CGFloat = 50
        spinner = UIActivityIndicatorView(frame: CGRect(x: view.center.x - width/2, y: view.center.y - height/2, width: width, height: height))
        spinner.color = UIColor.black
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
    }
    
    @IBAction func translateButton(_ sender: Any) {
        let inputText : String = morseInputView.text
        
        if inputText != morseCode.getWords() {
            translateText(text: inputText)
        }
    }
    
    func translateText(text: String) {
        spinner.startAnimating()
        DispatchQueue.global().async {
            do {
                self.morseCode = try MorseCode(textToTranslate: text)
                DispatchQueue.main.async {
                    self.morseOutputView.text = self.morseCode.getMorse()
                }
            } catch MorseCode.MorseError.characterNotInDictionary(missingCharacter: let char) {
                self.showAlertMessage(title: "Whoops!", message: "We couldn't translate '\(char)'")
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
            }
        }
    }
    
    @IBAction func playMorseCode(_ sender: Any) {
        spinner.startAnimating()
        DispatchQueue.global().async {
            do {
                try self.morseCode.playMorse()
            } catch {
                self.showAlertMessage(title: "Sorry!", message: "We couldn't play the audio right now!")
            }
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
            }
        }
    }
    
    func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

