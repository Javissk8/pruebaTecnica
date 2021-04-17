//
//  WaitingOrdersViewController.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 16/04/21.
//

import UIKit
import Alamofire

class WaitingOrdersViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var presenter = HomePresenter()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "WAITING".localized
        configureTableView()
        refreshControl.addTarget(self, action: #selector(refreshUsers(_:)), for: .valueChanged)
    }
    
    func getNewUser() {
        presenter.getUsers { [weak self] response in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        } error: { [weak self] error in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
            print(error)
        }
    }
    
    @objc private func refreshUsers(_ sender: Any) {
        getNewUser()
    }

    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.register(UINib(nibName: WaitingOrderTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: WaitingOrderTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
    }

}

extension WaitingOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UsersManager.shared.waitingUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let waitingCell = tableView.dequeueReusableCell(withIdentifier: WaitingOrderTableViewCell.reuseIdentifier) as? WaitingOrderTableViewCell, let safeModel = UsersManager.shared.waitingUsers[indexPath.row] else { return cell }
        waitingCell.configure(user: safeModel)
        cell = waitingCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width/3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionsActionSheet = UIAlertController(title: "ORDER_OPTIONS".localized, message: nil, preferredStyle: .actionSheet)
        
        let acceptOrderAction = UIAlertAction(title: "ACCEPT_ORDER".localized, style: .default) { (action) in
            UsersManager.shared.acceptedUsers.append(UsersManager.shared.waitingUsers[indexPath.row])
            UsersManager.shared.waitingUsers.remove(at: indexPath.row)
            tableView.deleteRows(at:[indexPath], with: .automatic)
            tableView.reloadData()
        }
        
        let cancelOrderAction = UIAlertAction(title: "CANCEL_ORDER".localized, style: .destructive) { (action) in
            UsersManager.shared.cancelledUsers.append(UsersManager.shared.waitingUsers[indexPath.row])
            UsersManager.shared.waitingUsers.remove(at: indexPath.row)
            tableView.deleteRows(at:[indexPath], with: .automatic)
            tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "CANCEL".localized, style: .cancel) { (action) in
            tableView.deselectRow(at: indexPath, animated: true)
        }
        optionsActionSheet.addAction(acceptOrderAction)
        optionsActionSheet.addAction(cancelOrderAction)
        optionsActionSheet.addAction(cancelAction)
        present(optionsActionSheet, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/5))
        headerView.backgroundColor = .systemGroupedBackground
        let headerLabel = UILabel()
        headerLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        headerLabel.textColor = .black
        headerLabel.textAlignment = .left
        headerLabel.text = "EMPTY_RESULTS".localized
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerLabel)
        headerLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 15).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return UsersManager.shared.waitingUsers.isEmpty ? headerView : UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UsersManager.shared.waitingUsers.isEmpty ? UIScreen.main.bounds.width/5 : .zero
    }
    
}
