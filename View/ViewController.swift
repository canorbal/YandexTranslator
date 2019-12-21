//
//  ViewController.swift
//  YandexTranslator
//
//  Created by Roman on 09/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: TextField!
    @IBOutlet weak var roundedUIView: RoundedUIView!
    @IBOutlet weak var englishImage: UIImageView!
    @IBOutlet weak var russianImage: UIImageView!
    @IBOutlet weak var changeLanguageButton: ChangeLanguageButton!
    @IBOutlet weak var speakOrSendMessageButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var englishLanguageModeIsOn: Bool = true
    var constraints: (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint)!
    
    var presenter: ViewPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ViewPresenter(view: self)
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: tableView.bounds.width - 8.0)
        
        registerAllNotifications()
        if let placeholder = self.textField.placeholder {
            self.textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : TextFieldAppearance.textFieldPlaceholderColor])
        }
        self.textField.cleareButtonWithImage(UIImage(named: "ClearButton")!)
        changeLanguageButton.addSubview(russianImage)
        changeLanguageButton.addSubview(englishImage)
        
        constraints = createConstraints()
        NSLayoutConstraint.activate([constraints.1, constraints.2])
        
        let recognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTableViewTap(recognizer:)))
        self.tableView.addGestureRecognizer(recognizer)
        
        self.textField.delegate = self
        
//        do {
//            try NetworkService.getInstance().getCurrentLanguage(text: "а") { (lang) in
//                if let lang = lang {
//                    print("LANG = \(lang)")
//                }
//            }
//        } catch {
//            print("ERROR")
//        }
//
        
    }
    
    @objc func didTableViewTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    deinit {
        removerAllNotifications()
    }

    @IBAction func changeLanguageTapped(_ sender: ChangeLanguageButton) {
        changeLanguage()
    }
    
    func changeLanguage()  {
        if englishLanguageModeIsOn {
            UIView.animate(withDuration: 0.3, animations: {
                self.roundedUIView.backgroundColor = TextFieldAppearance.russianModeBackgroundColor
                self.textField.placeholder = "Русский"
                
                NSLayoutConstraint.deactivate([self.constraints.1, self.constraints.2])
                self.changeLanguageButton.bringSubviewToFront(self.russianImage)
                let deltaX = self.englishImage.frame.origin.x - self.russianImage.frame.origin.x
                
                self.russianImage.frame.origin.x += deltaX
                self.englishImage.frame.origin.x -= deltaX
                
                NSLayoutConstraint.activate([self.constraints.0, self.constraints.3])
            }, completion: nil)
            
            if let placeholder = self.textField.placeholder {
                self.textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : TextFieldAppearance.textFieldPlaceholderColor])
            }
            englishLanguageModeIsOn = false
            
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.roundedUIView.backgroundColor = TextFieldAppearance.englishModeBackgroundColor
                self.textField.placeholder = "Английский"
                
                NSLayoutConstraint.deactivate([self.constraints.0, self.constraints.3])
                self.changeLanguageButton.bringSubviewToFront(self.englishImage)
                let deltaX = self.russianImage.frame.origin.x - self.englishImage.frame.origin.x
                
                self.englishImage.frame.origin.x += deltaX
                self.russianImage.frame.origin.x -= deltaX
                
                NSLayoutConstraint.activate([self.constraints.1, self.constraints.2])
                
            }, completion: nil)
            
            if let placeholder = self.textField.placeholder {
                self.textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : TextFieldAppearance.textFieldPlaceholderColor])
            }
            englishLanguageModeIsOn = true
        }
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        if let text = textField.text {
            self.presenter!.getTranslation(for: text, fromEnglishToRussian: self.englishLanguageModeIsOn)
            self.textField.text = ""
        }
        
    }
    
    
    func registerAllNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldWasCleared), name: NSNotification.Name("TextFieldClearedFromClearButton"), object: nil)
    }
    
    func removerAllNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("TextFieldClearedFromClearButton"), object: nil)
    }
    
    // Анимации не работают. 
    @objc func textFieldDidChange(_ notification: NSNotification) {
        self.textField.rightViewMode = .always
        self.speakOrSendMessageButton.setImage(UIImage(named: "SendButton"), for: .normal)
    }
    
    @objc func textFieldWasCleared() {
        self.textField.rightViewMode = .never
        self.speakOrSendMessageButton.setImage(UIImage(named: "SpeekButton"), for: .normal)
    }

    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.view.frame.origin = CGPoint(x: 0, y: -kbFrameSize.height)
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        self.view.frame.origin = CGPoint.zero
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func createConstraints() -> (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint) {
        let leftConstraintForEnglishImage: NSLayoutConstraint = NSLayoutConstraint(item: changeLanguageButton, attribute: .leading, relatedBy: .equal, toItem: englishImage, attribute: .trailing, multiplier: 1.0, constant: -34.0)
        
        let rightConstraintForEnglishImage: NSLayoutConstraint = NSLayoutConstraint(item: englishImage, attribute: .leading, relatedBy: .equal, toItem: changeLanguageButton, attribute: .trailing, multiplier: 1.0, constant: -34.0)
        
        let leftConstraintForRussianImage: NSLayoutConstraint = NSLayoutConstraint(item: changeLanguageButton, attribute: .leading, relatedBy: .equal, toItem: russianImage, attribute: .trailing, multiplier: 1.0, constant: -34.0)
        
        let rightConstraintForRussianImage: NSLayoutConstraint = NSLayoutConstraint(item: russianImage, attribute: .leading, relatedBy: .equal, toItem: changeLanguageButton, attribute: .trailing, multiplier: 1.0, constant: -34.0)
        
        return (leftConstraintForEnglishImage, rightConstraintForEnglishImage, leftConstraintForRussianImage, rightConstraintForRussianImage)
    }
    
}
