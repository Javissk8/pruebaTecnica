//
//  NavigationButtonTableViewCell.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 17/04/21.
//

import UIKit

protocol NavigationButtonTableViewCellDelegate: class {
    func goToNavigation()
}

class NavigationButtonTableViewCell: UITableViewCell {

    @IBOutlet private weak var navigationButton: UIButton!
    
    weak var delegate: NavigationButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        navigationButton.setBorderRoundStyle(color: .customCyan)
        navigationButton.addTarget(self, action: #selector(onClickGoToNavigation), for: .touchUpInside)
    }
    
    @objc func onClickGoToNavigation() {
        delegate?.goToNavigation()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
