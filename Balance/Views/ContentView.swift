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
	var body: some View {
//		NavigationView{
			
			TabView(selection: $tabSelection) {
				ScrollView{
					Home(accts: $accounts)
				}
				.tabItem {
					Image(systemName: "dollarsign.circle.fill")
					Text("Balances")
						.font(.system(.body, design: .rounded))
				}
				Settings()
					.tabItem {
						Image(systemName: "gearshape.2.fill")
						Text("Settings")
							.font(.system(.body, design: .rounded))
					}
			}
			
			
			//.navigationTitle("$\(moneyString(num:sum))") }
			
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
