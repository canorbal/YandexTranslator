//
//  TextField.swift
//  YandexTranslator
//
//  Created by Roman on 19/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit

class TextField: UITextField {

    func cleareButtonWithImage(_ image: UIImage) {
        let clearButton = UIButton()
        
        clearButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = TextFieldAppearance.clearButtonTintColor
        clearButton.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(self.clearFromClearButton(sender:)), for: .touchUpInside)
        self.rightView = clearButton
        self.rightViewMode = .never
    }
    
    @objc func clearFromClearButton(sender: AnyObject) {
        self.text = ""
        NotificationCenter.default.post(name: NSNotification.Name("TextFieldClearedFromClearButton"), object: nil, userInfo: nil)
    }
    
}
