//
//  ReuseIdentifier.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 16/04/21.
//

import Foundation

protocol ReuseIdentifier {
    
}

extension ReuseIdentifier where Self: Any {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
