//
//  Account.swift
//  Balance
//
//  Created by Jacob Tepperman on 2020-12-08.
//

import SwiftUI

let zero:NSString = "0"

struct Account: Equatable {
	let name: String
	let cryptoName: String
	let cryptoAmount: Double
	let realName: String
	let realAmount: Double
	let id: String
	var image: Image {return Image("\(cryptoName.uppercased())")}
	let cumulative: NSString
	static let empty = Account(name: "_____", cryptoName: "___", cryptoAmount: Double(), realName: "___", realAmount: Double(), id: "--------", cumulative: "00.00" as! NSString)
}
