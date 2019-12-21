//
//  File.swift
//  YandexTranslator
//
//  Created by Roman on 20/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

class ViewPresenter: ViewControllerPresenter {
    unowned let view: ViewProtocol
    var responses: [Response]
    
    required init(view: ViewProtocol) {
        self.view = view
        self.responses = [Response]()
    }
    
    func getTranslation(for text: String, fromEnglishToRussian: Bool) {
        do {
            try NetworkService.getInstance().getTranslation(for: text, lang: fromEnglishToRussian ? "en-ru" : "ru-en", completion: { (resp) in
                if let response = resp {
                    self.responses.append(response)
                    DispatchQueue.main.async {
                        self.view.insertResponseToView(response)
                    }
                }
            })
        } catch {
            DispatchQueue.main.async {
                self.view.showErrorMessage("some error!")
            }
        }
    }
    
    func detectLanguage(text: String) {
        do {
            try NetworkService.getInstance().getCurrentLanguage(text: text, complition: { (lang) in
                if let lang = lang {
                    DispatchQueue.main.async {
                        self.view.detectLanguage(lang)
                    }
                }
            })
        } catch {
            DispatchQueue.main.async {
                self.view.showErrorMessage("some error!")
            }
        }
    }
}
