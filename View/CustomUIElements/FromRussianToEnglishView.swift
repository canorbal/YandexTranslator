//
//  FromRussianToEnglishView.swift
//  YandexTranslator
//
//  Created by Roman on 19/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit

class FromRussianToEnglishView: UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCornerns(corners: [.bottomLeft, .topLeft, .topRight], radius: 16.0)
    }
}

extension FromRussianToEnglishView {
    func roundCornerns(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }

}
