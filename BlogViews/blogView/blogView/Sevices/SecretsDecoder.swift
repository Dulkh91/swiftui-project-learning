//
//  SecretsDecoder.swift
//  blogView
//
//  Created by Ros Dul on 20/5/26.
//

import Foundation

enum Secrets{
    static var blogAPIKey: String{
        guard let key = Bundle.main.infoDictionary?["API_TOKEN"] as? String else{
            fatalError("API Key not found in check Config.xccofig")
        }
        return key
    }
}
