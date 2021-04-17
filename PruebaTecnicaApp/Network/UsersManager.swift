//
//  UsersManager.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 16/04/21.
//

import Foundation
import Alamofire

class UsersManager {
    static let shared: UsersManager = UsersManager()
    
    var waitingUsers: [UserResult?] = []
    var acceptedUsers: [UserResult?] = []
    var cancelledUsers: [UserResult?] = []
    
    func getUsers(successHandler: @escaping([UserResult]) -> Void, errorHandler: @escaping(AFError?) -> Void) {
        let endpointString = "https://randomuser.me/api/"
        guard let endpoint = URL(string: endpointString) else { return }
        AF.request(endpoint, method: .get).responseJSON(completionHandler: { (response) in
            guard let dataFromService = response.data else {
                errorHandler(response.error)
                return
            }
            do {
                let model = try? JSONDecoder().decode(UsersInfo.self, from: dataFromService)
                guard let modelSafe = model?.results else {
                    errorHandler(AFError.explicitlyCancelled)
                    return}
                self.waitingUsers.append(modelSafe.first)
                successHandler(modelSafe)
            } catch let error as NSError {
                errorHandler(AFError.explicitlyCancelled)
            }
        })
    }
    
}
