//
//  ImageConstraints.swift
//  YandexTranslator
//
//  Created by roman on 10/12/2018.
//  Copyright © 2018 roman. All rights reserved.
//
import UIKit

class ImageConstraints {
    static let leftConstraintForEnglishImage: NSLayoutConstraint = NSLayoutConstraint(item: changeLanguageButton, attribute: .leading, relatedBy: .equal, toItem: Vi, attribute: .trailing, multiplier: 1.0, constant: -34.0)
    
    static let rightConstraintForEnglishImage: NSLayoutConstraint = NSLayoutConstraint(item: englishImage, attribute: .leading, relatedBy: .equal, toItem: changeLanguageButton, attribute: .trailing, multiplier: 1.0, constant: -34.0)
    
    static let leftConstraintForRussianImage: NSLayoutConstraint = NSLayoutConstraint(item: changeLanguageButton, attribute: .leading, relatedBy: .equal, toItem: russianImage, attribute: .trailing, multiplier: 1.0, constant: -34.0)
}
