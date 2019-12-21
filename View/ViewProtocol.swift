//
//  ViewProtocol.swift
//  YandexTranslator
//
//  Created by Roman on 20/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

protocol ViewProtocol: class {
    func insertResponseToView(_ response: Response)
    func showErrorMessage(_ errorMessage: String)
    func detectLanguage(_ lang: String)
}
