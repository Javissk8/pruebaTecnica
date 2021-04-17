//
//  RequesManager.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 16/04/21.
//

import Foundation
import Alamofire

class RequestManager {
    
    func validateData(response:AFDataResponse<Any>,nameFunc:String? = "") -> (String?,Data?) {
        if response.error != nil {
            return (response.error.debugDescription,nil)
        }
        
        guard let dataResponce = response.data else {
            return ("Data isn't available",nil)
        }
        return (nil,dataResponce)
    }
}

