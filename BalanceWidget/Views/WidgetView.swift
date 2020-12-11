//
//  WidgetView.swift
//  Balance
//
//  Created by Jacob Tepperman on 2020-12-09.
//

import SwiftUI
import WidgetKit

struct WidgetView: View {
	@State var accounts: [Account]
	@State var sum = Double()
	@Environment(\.widgetFamily) var family
	var body: some View {
		HStack{
			if family != .systemSmall {
				Text("$\(moneyString(num:sum))")
					.bold()
				Divider()
			}
			
			VStack {
				ForEach(0..<3){ i in
					
					WidgetAccountView(acct: $accounts[i])
						.padding(.vertical,0)
				}
				
			}
		}
		.onAppear(){
			WidgetCenter.shared.reloadAllTimelines()
			sum = 0
			accounts = getAccounts().sorted(by: {$0.realAmount > $1.realAmount})
			accounts.forEach { acct in
				if acct.cumulative.doubleValue > sum {
					sum = acct.cumulative.doubleValue
				}
			}
		}
	}
}
