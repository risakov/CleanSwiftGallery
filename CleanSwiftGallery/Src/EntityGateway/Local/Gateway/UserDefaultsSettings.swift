//
//  UserDefaultsSettings.swift
//  CleanSwiftGallery
//
//  Created by Роман on 06.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation

protocol UserDefaultsSettings {
    func read<T: Codable>(_ key: UserDefaultsKey) -> T?
    func saveData<T: Codable>(_ key: UserDefaultsKey, _ value: T?)
    func resetUserDefaults()
}

class UserDefaultsSettingsImp: UserDefaultsSettings {

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let userDefaults = UserDefaults(suiteName: "tizer")!

    func read<T: Codable>(_ key: UserDefaultsKey) -> T? {
        let keyValue = key.rawValue

        print("UserDefaults: reading key: \(keyValue) of type: \(T.self)")
        let value = userDefaults.value(forKey: keyValue)

        switch T.self {
            case is String.Type: return userDefaults.string(forKey: keyValue) as? T
            case is Double.Type: return userDefaults.double(forKey: keyValue) as? T
            case is Float.Type:  return userDefaults.float(forKey: keyValue) as? T
            case is Bool.Type:   return userDefaults.bool(forKey: keyValue) as? T
            case is Int.Type:    return userDefaults.integer(forKey: keyValue) as? T
            default:
                guard let data = value as? Data else { return nil }
                return try? decoder.decode(T.self, from: data)
        }
    }

    func saveData<T: Codable>(_ key: UserDefaultsKey, _ value: T?) {
        print("UserSettings: save '\(key)' = '\(value)' of type: \(T.self)")
        let keyValue = key.rawValue
        if value == nil {
            userDefaults.set(nil, forKey: keyValue)
            return
        }
        switch value {
            case is String: userDefaults.set(value as! String, forKey: keyValue)
            case is Double: userDefaults.set(value as! Double, forKey: keyValue)
            case is Float:  userDefaults.set(value as! Float, forKey: keyValue)
            case is Bool:   userDefaults.set(value as! Bool, forKey: keyValue)
            case is Int:    userDefaults.set(value as! Int, forKey: keyValue)
            default:
                let data = try! encoder.encode(value)
                userDefaults.set(data, forKey: keyValue)
        }
        userDefaults.synchronize()
    }

    public func resetUserDefaults() {
        UserDefaultsKey.allCases.forEach { key in
            self.userDefaults.removeObject(forKey: key.rawValue)
        }
        self.userDefaults.synchronize()
    }
}
