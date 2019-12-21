//
//  NetworkService.swift
//  YandexTranslator
//
//  Created by Roman on 20/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

class NetworkService {
    private static var instance: NetworkService?
    
    private init() {}
    
    static func getInstance() -> NetworkService {
        if instance == nil {
            instance = NetworkService()
        }
        return instance!
    }
    
    func getTranslation(for text: String, lang: String, completion: @escaping (Response?) -> ()) throws {
        var responseForReturn: Response?
        
        guard let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw NetworkServiceError.encodingTextError
        }
        let urlString: String = "\(NetworkConstants.staticTranslateUrlString)?key=\(NetworkConstants.key)&text=\(encodedText)&lang=\(lang)"
        
        guard let url = URL(string: urlString) else {
            throw NetworkServiceError.invalidURL
        }
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            if let _ = response, let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                    let responseArray = json!["text"] as! Array<String>
                    
                    responseForReturn = Response(message: text, translation: responseArray[0], fromEnglishToRussian: lang == "en-ru" ? true : false)
                    completion(responseForReturn)
                }
                catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    func getCurrentLanguage(text: String, complition: @escaping (String?) -> ()) throws {
        var lang: String?
        
        guard let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw NetworkServiceError.encodingTextError
        }
        
        let urlString: String = "\(NetworkConstants.staticDetectUrlString)?key=\(NetworkConstants.key)&text=\(encodedText)&hint=ru,en"
        
        guard let url = URL(string: urlString) else {
            throw NetworkServiceError.invalidURL
        }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let _ = response, let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                    lang = json!["lang"] as? String
                    complition(lang)
                } catch {
                    complition(nil)
                }
            } else {
                complition(nil)
            }
        }.resume()
    }
}
