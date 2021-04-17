//
//  AcceptedOrderTableViewCell.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 17/04/21.
//

import UIKit
import AlamofireImage
import CoreLocation

class AcceptedOrderTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = userImageView.frame.size.width/2
    }
    
    func configureCell(user: UserResult, currentLocation: CLLocation?) {
        locationLabel.text = "ADDRESS".localized + "\(user.location?.street?.name ?? "") \(user.location?.street?.number ?? 0), \(user.location?.city ?? "")"
        distanceLabel.text = "DISTANCE".localized + "UNAVAILABLE".localized
        if let deliveryLocation = currentLocation {
            let from = deliveryLocation
            let to = CLLocation(latitude: CLLocationDegrees(Float(user.location?.coordinates?.latitude ?? "") ?? 0.0), longitude: CLLocationDegrees(Float(user.location?.coordinates?.longitude ?? "") ?? 0.0))
            distanceLabel.text = "DISTANCE".localized + "\((from.distance(from: to)/1000).truncate(places: 2)) Km"
        }
        guard let imageUrl = URL(string: user.picture?.thumbnail ?? "") else { return }
        userImageView.af.setImage(withURL: imageUrl)
        userImageView.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
