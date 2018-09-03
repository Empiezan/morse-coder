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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func translateButton(_ sender: Any) {
        let inputText : String = morseInputView.text
        
        do {
            morseCode = try MorseParagraph(textToTranslate: inputText)
        } catch {
            let alert = UIAlertController(title: "Whoops!", message: "We couldn't recognize one or more of the characters!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        morseOutputView.text = morseCode.getMorse()
    }
    
    @IBAction func playMorseCode(_ sender: Any) {
        do {
            try morseCode.playMorse()
        } catch {
            let alert = UIAlertController(title: "Sorry!", message: "We couldn't play the audio!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

