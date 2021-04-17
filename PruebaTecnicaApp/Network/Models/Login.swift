//
//  Login.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 16/04/21.
//

import Foundation

struct Login : Codable {
	let uuid : String?
	let username : String?
	let password : String?
	let salt : String?
	let md5 : String?
	let sha1 : String?
	let sha256 : String?
}
