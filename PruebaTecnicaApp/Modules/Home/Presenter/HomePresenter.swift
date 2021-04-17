//
//  HomePresenter.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 16/04/21.
//

import Foundation
import Alamofire

class HomePresenter {
    func getUsers(users: @escaping([UserResult]?) -> Void, error: @escaping(AFError?) -> Void) {
        UsersManager.shared.getUsers(successHandler: users, errorHandler: error)
    }
}
