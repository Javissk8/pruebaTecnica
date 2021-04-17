//
//  StringExtension.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 16/04/21.
//

import Foundation

var tableName = "Localizables"

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: tableName, bundle:  Bundle.main, value: "", comment: "")
    }
}
