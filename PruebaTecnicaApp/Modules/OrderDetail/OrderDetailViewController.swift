//
//  OrderDetailViewController.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 17/04/21.
//

import UIKit
import Alamofire
import CoreLocation

class OrderDetailViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private enum orderDetailsSection: Int {
        case profile = 0
        case mapView
        case navigation
    }
    
    var currentUser: UserResult?
    var userLocation: CLLocationCoordinate2D?
    let numberOfSections = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configure(user: UserResult, location: CLLocationCoordinate2D?) {
        currentUser = user
        userLocation = location
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: UserDetailTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: UserDetailTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: LocationMapTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: LocationMapTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: NavigationButtonTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NavigationButtonTableViewCell.reuseIdentifier)
    }
}

extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        guard let section = orderDetailsSection(rawValue: indexPath.section) else { return cell }
        switch section {
        case .profile:
            guard let userInfoCell = tableView.dequeueReusableCell(withIdentifier: UserDetailTableViewCell.reuseIdentifier) as? UserDetailTableViewCell, let safeModel = currentUser else { return cell }
            userInfoCell.configureCell(user: safeModel)
            cell = userInfoCell
        case .mapView:
            guard let mapViewCell = tableView.dequeueReusableCell(withIdentifier: LocationMapTableViewCell.reuseIdentifier) as? LocationMapTableViewCell, let safeModel = currentUser else { return cell }
            mapViewCell.configureMap(user: safeModel)
            cell = mapViewCell
        case .navigation:
            guard let navigationCell = tableView.dequeueReusableCell(withIdentifier: NavigationButtonTableViewCell.reuseIdentifier) as? NavigationButtonTableViewCell else { return cell }
            navigationCell.delegate = self
            cell = navigationCell
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let tableSection = orderDetailsSection(rawValue: indexPath.section) else { return .zero }
        switch tableSection {
        case .profile:
            return UIScreen.main.bounds.width/2
        case .mapView:
            return UIScreen.main.bounds.width
        case .navigation:
            return UIScreen.main.bounds.width/4
        }
    }
    
}

extension OrderDetailViewController: NavigationButtonTableViewCellDelegate {
    func goToNavigation() {
        let navAlert = UIAlertController(title: "WANT_TO_NAVIGATE".localized, message: "", preferredStyle: .actionSheet)
        let navAction = UIAlertAction(title: "GO_TO_MAPS".localized, style: .default) { (action) in
            guard let url = URL(string: "http://maps.apple.com/maps?daddr=\(self.currentUser?.location?.coordinates?.latitude ?? ""),\(self.currentUser?.location?.coordinates?.longitude ?? "")") else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        navAlert.addAction(navAction)
        navAlert.addAction(UIAlertAction(title: "CANCEL".localized, style: .cancel, handler: nil))
        self.present(navAlert, animated: true, completion: nil)

    }
    
    
}
