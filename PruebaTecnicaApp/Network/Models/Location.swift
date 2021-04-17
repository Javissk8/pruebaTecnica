//
//  Location.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 16/04/21.
//

import Foundation

struct Location : Codable {
	let street : Street?
	let city : String?
	let state : String?
	let country : String?
	let postcode : Int?
	let coordinates : Coordinates?
	let timezone : Timezone?
}
