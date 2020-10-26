//
//  Date + Convertation.swift
//  CleanSwiftGallery
//
//  Created by Роман on 14.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation

extension Date {
    
    static func convertToStringInCurrentFormat(rawDate: String?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let day = rawDate {
            let date = formatter.date(from: day)
            formatter.dateFormat = "dd.MM.yyyy"
            return formatter.string(from: date!)
        }
            
        else {
            return "Неправильный формат даты"
        }
    }
    
    static func convertToRawDate(currentDate: String?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        if let day = currentDate {
            let date = formatter.date(from: day)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return formatter.string(from: date!)
        }
        else {
            return "Неправильный формат даты"
        }
    }
    
}
