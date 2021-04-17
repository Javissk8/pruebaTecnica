//
//  Icons.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 16/04/21.
//

import UIKit

struct Icons {
    struct TabBarItems {
        static let waiting: UIImage = UIImage(named: "waiting_icon") ?? UIImage()
        static let accepted: UIImage = UIImage(named: "accepted_icon") ?? UIImage()
    }
    
    struct Orders {
        static let accepted: UIImage = UIImage(named: "accepted_order_icon") ?? UIImage()
        static let cancelledOrder: UIImage = UIImage(named: "cancelled_order_icon") ?? UIImage()
    }
}
