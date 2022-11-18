//
//  LanguageManager.swift
//  HitachiTest
//
//  Created by Superman on 18/11/2022.
//

import UIKit
import Localize_Swift

enum kLanguageType: String {
    
    case kEnglish = "en"
    case kMalay = "ms"
    
    static let allValues = [kEnglish, kMalay]
    static let alllocalizedStr = [kEnglish, kMalay].map { (type) -> String in
        return type.rawValue
    }
    
    func localizedStr() -> String {
        switch self {
        case .kEnglish:
            return "en"
        case .kMalay:
            return "ms"
        }
    }
    
    func languageStr() -> String {
        switch self {
        case .kEnglish:
            return "English"
        case .kMalay:
            return "Malay"
        }
    }
}

class LanguageManager: NSObject {
    
    static let shared = LanguageManager()
    
    var selectedLanguage: kLanguageType = kLanguageType.kEnglish
    
    override init() {}
    
    func initConfig() {
        let language: String = UserStorage.currentLanguage
        self.selectedLanguage = kLanguageType.init(rawValue: language) ?? kLanguageType.kEnglish
        Localize.setCurrentLanguage(language)
    }
    
    func setCurrentLanguage(_ languageType: kLanguageType) {
        if languageType == self.selectedLanguage {
            return
        }
        
        LanguageManager.shared.selectedLanguage = languageType
        UserStorage.currentLanguage = languageType.rawValue
        Localize.setCurrentLanguage(languageType.rawValue)
    }
    

}

