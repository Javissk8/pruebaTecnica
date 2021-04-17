//
//  UserResult.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 16/04/21.
//

import Foundation

struct UserResult : Codable {
	let gender : String?
	let name : Name?
	let location : Location?
	let email : String?
	let login : Login?
	let dob : Dob?
	let registered : Registered?
	let phone : String?
	let cell : String?
	let id : Id?
	let picture : Picture?
	let nat : String?
}
