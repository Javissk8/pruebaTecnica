//
//  UIButtonExtension.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 17/04/21.
//

import UIKit

extension UIButton {
    func setBorderRoundStyle(color:UIColor? = UIColor.white){
        self.layer.cornerRadius = 10
        self.backgroundColor = color
        self.tintColor = .white
    }
}
