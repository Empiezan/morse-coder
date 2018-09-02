//
//  CleanTextView.swift
//  morse-coder
//
//  Created by labuser on 9/2/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit

class CleanTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFrame()
        setupShadow()
    }
    
    func setupFrame() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.1
        layer.cornerRadius = 2
        textContainerInset = UIEdgeInsetsMake(8, 5, 8, 5)
    }
    
    func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.4
    }
}
