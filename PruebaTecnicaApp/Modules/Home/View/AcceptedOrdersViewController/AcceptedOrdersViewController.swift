//
//  AcceptedOrdersViewController.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 16/04/21.
//

import UIKit
import CoreLocation

class AcceptedOrdersViewController: UIViewController {

    @IBOutlet private weak var ordersSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    private enum ordersSection: Int {
        case accepted = 0
        case cancelled
    }
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    private var numberOfSections = 2
    private var heightForAcceptedRow: CGFloat = 0
    private var heightForCancelledRow: CGFloat = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "ORDERS".localized
        configureTableView()
        reloadTableViewHeight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAuthorization()
        tabBarController?.tabBar.isHidden = false
    }
    
    func reloadTableViewHeight() {
        guard let section = ordersSection(rawValue: ordersSegmentedControl.selectedSegmentIndex) else { return }
        switch section {
        case .accepted:
            heightForAcceptedRow = UIScreen.main.bounds.width/4
            heightForCancelledRow = 0
        case .cancelled:
            heightForAcceptedRow = 0
            heightForCancelledRow = UIScreen.main.bounds.width/5
        }
        UIView.transition(with: tableView,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 0
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: AcceptedOrderTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: AcceptedOrderTableViewCell.reuseIdentifier)
        
    }
    
    func getAuthorization(){
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.stopUpdatingLocation()
            tableView.reloadData()
        }
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            currentLocation = locationManager.location
        }
        else {
            currentLocation = nil
        }
    }

    @IBAction func onTouchOrderControl(_ sender: Any) {
        guard let section = ordersSection(rawValue: ordersSegmentedControl.selectedSegmentIndex) else { return }
        switch section {
        case .accepted:
            heightForAcceptedRow = UIScreen.main.bounds.width/4
            heightForCancelledRow = 0
        case .cancelled:
            heightForAcceptedRow = 0
            heightForCancelledRow = UIScreen.main.bounds.width/5
        }
        UIView.transition(with: tableView,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })
    }
}

extension AcceptedOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableSection = ordersSection(rawValue: section) else { return .zero }
        switch tableSection {
        case .accepted:
            return UsersManager.shared.acceptedUsers.count
        case .cancelled:
            return UsersManager.shared.cancelledUsers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let section = ordersSection(rawValue: indexPath.section) else { return cell }
        switch section {
        case .accepted:
            guard let acceptedOrderCell = tableView.dequeueReusableCell(withIdentifier: AcceptedOrderTableViewCell.reuseIdentifier) as? AcceptedOrderTableViewCell, let safeModel = UsersManager.shared.acceptedUsers[indexPath.row] else { return cell }
            acceptedOrderCell.configureCell(user: safeModel, currentLocation: currentLocation)
            cell = acceptedOrderCell
        case .cancelled:
            if let imageUrl = URL(string: UsersManager.shared.cancelledUsers[indexPath.row]?.picture?.medium ?? "") {
                cell.imageView?.af.setImage(withURL: imageUrl)
            }
            cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 12)
            cell.textLabel?.text = "ADDRESS".localized + "\(UsersManager.shared.cancelledUsers[indexPath.row]?.location?.street?.name ?? "") \(UsersManager.shared.cancelledUsers[indexPath.row]?.location?.street?.number ?? 0), \(UsersManager.shared.cancelledUsers[indexPath.row]?.location?.city ?? "")"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = ordersSection(rawValue: indexPath.section) else { return }
        switch section {
        case .accepted:
            guard let safeModel = UsersManager.shared.acceptedUsers[indexPath.row] else { return }
            tabBarController?.tabBar.isHidden = true
            let orderDetailsVC = OrderDetailViewController()
            orderDetailsVC.modalPresentationStyle = .fullScreen
            orderDetailsVC.configure(user: safeModel, location: currentLocation?.coordinate)
            navigationController?.pushViewController(orderDetailsVC, animated: true)
        case .cancelled:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = ordersSection(rawValue: indexPath.section) else { return .zero }
        switch section {
        case .accepted:
            return heightForAcceptedRow
        case .cancelled:
            return heightForCancelledRow
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
}

extension AcceptedOrdersViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Found user's location: \(location)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            currentLocation = locationManager.location
        default:
            break
        }
    }
}
