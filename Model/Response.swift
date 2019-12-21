//
//  File.swift
//  YandexTranslator
//
//  Created by Roman on 19/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

class Response {
    var message: String
    var translation: String
    var fromEnglishToRussian: Bool
    
    init(message: String, translation: String, fromEnglishToRussian: Bool) {
        self.message = message
        self.translation = translation
        self.fromEnglishToRussian = fromEnglishToRussian
    }
}
