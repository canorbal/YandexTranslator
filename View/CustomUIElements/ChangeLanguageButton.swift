//
//  TChangeLanguageButton.swift
//  YandexTranslator
//
//  Created by Roman on 10/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit

@IBDesignable class ChangeLanguageButton: UIButton {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
