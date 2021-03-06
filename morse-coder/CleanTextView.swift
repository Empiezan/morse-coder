//
//  CleanTextView.swift
//  morse-coder
//
//  Created by labuser on 9/2/18.
//  Copyright © 2018 mc. All rights reserved.
//
// Credit
// 1. Creating "padding" for textview ( https://stackoverflow.com/questions/7902990/add-padding-to-a-uitextview)
// 2. Identifying screen sizes (https://stackoverflow.com/questions/25025779/setting-uilabel-text-to-bold)

import UIKit

class CleanTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFrame()
        font = UIFont.systemFont(ofSize: getFontSize())
    }
    
    func setupFrame() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.1
        layer.cornerRadius = 2
        textContainerInset = UIEdgeInsetsMake(8, 5, 8, 5)
    }
    
    func getFontSize() -> CGFloat {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            /// iPhone 5/5C/5S
            case 1136:
                return 16
            /// iPhone 6/6S/7/8
            case 1334:
                return 18
            /// iPhone 6+/6S+/7+/8+
            case 1920, 2208:
                return 20
            /// iPhone X
            case 2436:
                return 20
            default:
                return 16
            }
        } else {
            switch UIScreen.main.nativeBounds.height {
            /// 7.9" and 9.7" iPad mini
            case 2048:
                return 30
            /// 10.5" iPad Pro
            case 2224:
                return 35
            /// 12.9" iPad Pro
            case 2732:
                return 40
            default:
                return 30
            }
        }
    }
}
