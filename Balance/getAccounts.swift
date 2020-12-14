//
//  getAccounts.swift
//  Balance
//
//  Created by Jacob Tepperman on 2020-12-08.
//

import Foundation





func getAccounts() -> [Account] {
	var total = Double()
	var end = [[String:String]]()
	var txt = "init"
	var output = [Account]()
	let key = UserDefaults.init(suiteName: "group.jtepp.Balance")!.string(forKey: "key") ?? ""
	let secret = UserDefaults.init(suiteName: "group.jtepp.Balance")!.string(forKey: "secret") ?? ""
	let url = URL(string: "https://allpurpose.netlify.app/.netlify/functions/coinbase?key=\(friendlyString(s:key))&secret=\(friendlyString(s:secret))")!
	let fail = [Account.empty]
	
	if key.count > 2 && secret.count > 2 {
	do {
		txt = try String(contentsOf: url)
	} catch {
		txt = #"[["error":"failed"]]"#
		print(false)
		return fail
	}
	if txt != "error" {
	do {
		// make sure this JSON is in the format we expect
		let jend = try JSONSerialization.jsonObject(with: Data(txt.utf8), options: []) as! [[String:String]]
		end = jend
	} catch let error as NSError {
		print("Failed to load: \(error.localizedDescription)")
		return fail
	}
	
	end.forEach { acct in
		let cA = acct["cryptoAmount"] as! NSString
		let rA = acct["realAmount"] as! NSString
		total += rA.doubleValue
		
		
		output.append( Account(name: acct["name"] ?? "name",buy: acct["buy"] as! NSString, cryptoName: acct["cryptoName"] ?? "bn", cryptoAmount: cA.doubleValue, realName: acct["realName"] ?? "nn", realAmount: rA.doubleValue, id: acct["id"] ?? "id", cumulative: moneyString(num: total) as! NSString))
	}
	
	return output
	}
	else {
		return fail
	}
	
	}
	else {
		return fail
	}
	
}

func moneyString(num: Double) -> String {
	let n = NumberFormatter()
		n.minimumFractionDigits = 2
	return n.string(for: num)!
}

func friendlyString(s:String) -> String {
	var q = s.replacingOccurrences(of: " ", with: "")
	q = q.replacingOccurrences(of: "?", with: "")
	q = q.replacingOccurrences(of: "&", with: "")
	q = q.replacingOccurrences(of: "/", with: "")
	return q
}
