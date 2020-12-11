//
//  Details.swift
//  Balance
//
//  Created by Jacob Tepperman on 2020-12-10.
//

import SwiftUI

struct Details: View {
	@State var key = UserDefaults.init(suiteName: "group.jtepp.Balance")!.string(forKey: "key") ?? ""
	@State var secret = UserDefaults.init(suiteName: "group.jtepp.Balance")!.string(forKey: "secret") ?? ""
	var body: some View	{
		ScrollView	{
			
			TextField("API Key", text: $key)
				.onChange(of: key){ _ in
					UserDefaults.init(suiteName: "group.jtepp.Balance")!.set(key, forKey: "key")
				}
			TextField("API Secret", text: $secret)
				.onChange(of: secret){ _ in
					UserDefaults.init(suiteName: "group.jtepp.Balance")!.set(secret, forKey: "secret")
				}
			Text("Make sure your keys are READ-ONLY for your own security.\n\nThe creator of this app is not responsible for any damages caused to the users or their assets. (There's literally nothing in this app that could be held responsible anyway).\n\nPlease note Coinbase API keys activate after 48 hours of creation. Also note that enabling more wallets (more than 10) will increase lag in this app. It should also be noted that there is bug with the Coinbase API where enabling over 25 wallets will remove the BTC wallet from appearing.")
				.multilineTextAlignment(.center)
				.font(.system(.caption2, design:.rounded))
				.foregroundColor(.secondary)
			
			
		}
		.padding(.horizontal, 20)
		.accentColor(Color("coinbase"))
		.navigationTitle("API Configuration")
		.onAppear(){
			key = UserDefaults.init(suiteName: "group.jtepp.Balance")!.string(forKey: "key") ?? ""
			secret = UserDefaults.init(suiteName: "group.jtepp.Balance")!.string(forKey: "secret") ?? ""
		}
	}
}
