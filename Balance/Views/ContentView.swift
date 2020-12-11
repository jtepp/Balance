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
	@State var showAll = UserDefaults.standard.bool(forKey: "showAll")
	var body: some View {
//		NavigationView{
			
			TabView(selection: $tabSelection) {
				ScrollView{
					Home(accts: $accounts, showAll: $showAll)
				}
				.tabItem {
					Image(systemName: "dollarsign.circle.fill")
					Text("Balances")
						.font(.system(.body, design: .rounded))
				}
				Settings(showAll: $showAll)
					.tabItem {
						Image(systemName: "gearshape.2.fill")
						Text("Settings")
							.font(.system(.body, design: .rounded))
					}
			}
			
			
			//.navigationTitle("$\(moneyString(num:sum))") }
			.accentColor(Color("coinbase"))
			.onAppear{
				accounts = getAccounts()
			}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
