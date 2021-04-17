//
//  WaitingOrderTableViewCell.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 16/04/21.
//

import UIKit

class WaitingOrderTableViewCell: UITableViewCell {

    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(user: UserResult) {
        fullNameLabel.text = "NAME".localized + "\(user.name?.title ?? "") \(user.name?.first ?? "") \(user.name?.last ?? "")"
        locationLabel.text = "LOCATION".localized + "\(user.location?.city ?? ""), \(user.location?.state ?? "")"
        emailLabel.text = "EMAIL".localized + (user.email ?? "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
