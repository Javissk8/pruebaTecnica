//
//  UIColorExtension.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 17/04/21.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
 
    class var customCyan: UIColor {
        return UIColor.init(red: 65, green: 202, blue: 217)
    }
    class var customRed: UIColor {
        return UIColor.init(red: 255, green: 0, blue: 51)
    }
}
