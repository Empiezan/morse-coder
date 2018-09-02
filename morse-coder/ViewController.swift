//
//  ViewController.swift
//  morse-coder
//
//  Created by macos on 7/21/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var morseInputField: UITextField!
    @IBOutlet weak var morseTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func translateButton(_ sender: Any) {
        let inputText : String = morseInputField.text ?? ""

        morseTextLabel.text = inputText
    }
}

