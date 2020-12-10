//
//  ContentView.swift
//  Balance
//
//  Created by Jacob Tepperman on 2020-12-08.
//

import SwiftUI



struct ContentView: View {
	@State var accounts = [Account]()
	@State var sum = Double()
	var body: some View {
		NavigationView{
			
			ScrollView{
				Home(accts: $accounts, sum: $sum)
					.font(.system(.body, design: .rounded))
			}
			.navigationTitle("$\(moneyString(num:sum))")

			
			
			
			
		}
		.onAppear(){
			accounts = getAccounts().sorted(by: { $0.realAmount > $1.realAmount})
			//			print(accounts)
			accounts.forEach { acct in
				if acct.cumulative.doubleValue > sum {
					sum = acct.cumulative.doubleValue
				}
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
