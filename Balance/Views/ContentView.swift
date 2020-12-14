//
//  ContentView.swift
//  Balance
//
//  Created by Jacob Tepperman on 2020-12-08.
//

import SwiftUI



struct ContentView: View {
	@State var accounts = [Account]()
	@State var tabSelection = "home"
	@State var showAll = UserDefaults.init(suiteName: "group.jtepp.Balance")!.bool(forKey: "showAll")
	@State var showHelp = false
	var body: some View {

			TabView(selection: $tabSelection) {
				ScrollView{

						Home(accts: $accounts, showAll: $showAll, showHelp: $showHelp)
							.navigationTitle("")
							.navigationBarHidden(true)

				}
				.tabItem {
					Image(systemName: "dollarsign.circle.fill")
					Text("Balances")
						.font(.system(.body, design: .rounded))
				}
				Settings(showAll: $showAll)
					.navigationTitle("")
					.navigationBarHidden(true)
					.tabItem {
						Image(systemName: "gearshape.2.fill")
						Text("Settings")
							.font(.system(.body, design: .rounded))
					}
			}
			
		
		
			.accentColor(Color("coinbase"))
			.onAppear{
				accounts = getAccounts()
				if accounts == [Account.empty] || accounts.isEmpty {
					showHelp = true
				} else { showHelp = false }
			}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
