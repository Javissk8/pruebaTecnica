//
//  CustomDateFormatter.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 16/04/21.
//

import Foundation

class CustomDateFormatter: DateFormatter {
    
    static let shared: CustomDateFormatter = CustomDateFormatter()
    
    override init() {
        super.init()
        self.locale = Locale.current
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func dateFormatter(dateToFormat: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        dateFormatterGet.locale = Locale(identifier: "es_MX")
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "d MMMM yyyy"
        dateFormatterPrint.locale = Locale(identifier: "es_MX")
        dateFormatterPrint.timeZone = TimeZone(abbreviation: "GMT-5:00")
//        dateFormatterPrint.monthSymbols = dateFormatterPrint.monthSymbols.map { $0.localizedCapitalized }
        
        if let date = dateFormatterGet.date(from: dateToFormat) {
            return dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        return ""
    }

}
