//
//  ViewControllerPresenter.swift
//  YandexTranslator
//
//  Created by Roman on 20/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

protocol ViewControllerPresenter {
    init(view: ViewProtocol)
    func getTranslation(for text: String, fromEnglishToRussian: Bool)
    func detectLanguage(text: String) 
}
