//
//  ViewControllerTableExtension.swift
//  YandexTranslator
//
//  Created by Roman on 19/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.responses.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reversedResponses: [Response] = presenter!.responses.reversed()
        
        if reversedResponses[indexPath.section].fromEnglishToRussian {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FromEnglishToRussianMessageCell") as! FromEnglishToRussianCell
            cell.messageLabel.text = reversedResponses[indexPath.section].message
            cell.translationLabel.text = reversedResponses[indexPath.section].translation
            
            cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FromRussianToEnglishMessageCell") as! FromRussianToEnglishCell
            cell.messageLabel.text = reversedResponses[indexPath.section].message
            cell.translationLabel.text = reversedResponses[indexPath.section].translation
            
            cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            return cell
        }
    }
    
    
}

extension ViewController: ViewProtocol {
    func insertResponseToView(_ response: Response) {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .top)
        tableView.endUpdates()
        tableView.scrollToRow(at: indexPath, at: .top, animated: true) // TODO: посмотреть как работает
    }
    
    func showErrorMessage(_ errorMessage: String) {
        
    }
    
    func detectLanguage(_ lang: String) {
        switch lang {
        case "ru" where englishLanguageModeIsOn:
            changeLanguage()
        case "en" where !englishLanguageModeIsOn:
            changeLanguage()
        default:
            print("Lang = \(lang). No need to change a language!")
        }
    }

}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count == 1 && string.count > 0 {
            self.presenter.detectLanguage(text: textField.text!)
        }
        return true
    }
}

