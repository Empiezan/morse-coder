//
//  CleanTextView.swift
//  morse-coder
//
//  Created by labuser on 9/2/18.
//  Copyright © 2018 mc. All rights reserved.
//
// Credit
// 1. Creating "padding" for textview ( https://stackoverflow.com/questions/7902990/add-padding-to-a-uitextview)

import UIKit

class CleanTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFrame()
    }
    
    func setupFrame() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.1
        layer.cornerRadius = 2
        textContainerInset = UIEdgeInsetsMake(8, 5, 8, 5)
    }
}
