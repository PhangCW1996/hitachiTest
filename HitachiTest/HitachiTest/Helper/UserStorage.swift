//
//  UserDefaultsStorage.swift
//  HitachiTest
//
//  Created by Superman on 18/11/2022.
//


import Foundation
import UIKit

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

@propertyWrapper
struct UserDefaultsStorage<Value> {
    
    private let key: String
    private let defaultValue: Value
    private let storage: UserDefaults
    
    init(wrappedValue defaultValue: Value, key: String, storage: UserDefaults = .standard)
    {
        
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
    
    var wrappedValue: Value {
        get {
            let value = storage.value(forKey: self.key) as? Value
            return value ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                self.storage.removeObject(forKey: self.key)
            } else {
                self.storage.setValue(newValue, forKey: self.key)
            }
        }
    }
    
}

struct UserStorage {
    // MARK: - keys
    static private let currentLanguageKey = "language"
    
    @UserDefaultsStorage<String>(key: currentLanguageKey)
    static var currentLanguage: String = kLanguageType.kEnglish.localizedStr()
    

}



