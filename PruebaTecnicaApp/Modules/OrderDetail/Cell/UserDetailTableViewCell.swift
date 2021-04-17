//
//  UserDetailTableViewCell.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 17/04/21.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {

    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var birthDateLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(user: UserResult) {
        fullNameLabel.text = "NAME".localized + "\(user.name?.title ?? "") \(user.name?.first ?? "") \(user.name?.last ?? "")"
        emailLabel.text = "EMAIL".localized + (user.email ?? "")
        birthDateLabel.text = CustomDateFormatter.shared.dateFormatter(dateToFormat: user.dob?.date ?? "")
        cityLabel.text = "CITY".localized + (user.location?.city ?? "")
        stateLabel.text = "STATE".localized + (user.location?.state ?? "")
        countryLabel.text = "COUNTRY".localized + (user.location?.country ?? "")
        guard let imageUrl = URL(string: user.picture?.large ?? "") else { return }
        userImageView.af.setImage(withURL: imageUrl)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
