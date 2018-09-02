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
    @IBOutlet weak var morseTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        morseInputView.setContentOffset(CGPoint.zero, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func translateButton(_ sender: Any) {
        let inputText : String = morseInputView.text ?? ""

        let morseTranslation = MorseParagraph(textToTranslate: inputText).getMorse()
        
        morseTextLabel.text = morseTranslation
    }
}

