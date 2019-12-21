//
//  RoundedUIImageView.swift
//  YandexTranslator
//
//  Created by Roman on 19/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit

@IBDesignable class RoundedUIImageView: UIImageView {
    @IBInspectable
    var cornerRadius: CGFloat = 16.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = CommonAppearance.whiteColor {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}
