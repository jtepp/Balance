//
//  getAccounts.swift
//  Balance
//
//  Created by Jacob Tepperman on 2020-12-08.
//

import Foundation



let url = URL(string: "https://allpurpose.netlify.app/.netlify/functions/coinbase")!

func getAccounts() -> [Account] {
	var total = Double()
	var end = [[String:String]]()
	var txt = "init"
	var output = [Account]()
	do {
		txt = try String(contentsOf: url)
	} catch {
		txt = #"[["error":"failed"]]"#
		print(false)
	}
	
	do {
		// make sure this JSON is in the format we expect
		let jend = try JSONSerialization.jsonObject(with: Data(txt.utf8), options: []) as! [[String:String]]
		end = jend
	} catch let error as NSError {
		print("Failed to load: \(error.localizedDescription)")
	}
	
	end.forEach { acct in
		let cA = acct["cryptoAmount"] as! NSString
		let rA = acct["realAmount"] as! NSString
		total += rA.doubleValue
		
		
		output.append( Account(name: acct["name"] ?? "name", cryptoName: acct["cryptoName"] ?? "bn", cryptoAmount: cA.doubleValue, realName: acct["realName"] ?? "nn", realAmount: rA.doubleValue, id: acct["id"] ?? "id", cumulative: moneyString(num: total) as! NSString))
	}
	
	return output
	
	
	
}

func moneyString(num: Double) -> String {
	let n = NumberFormatter()
		n.minimumFractionDigits = 2
	return n.string(for: num)!
}
