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
	@State var showAll = UserDefaults.init(suiteName: "group.jtepp.Balance")!.bool(forKey: "showAll")
	var body: some View {
		HStack{
			if family != .systemSmall {
				Text(" $\(moneyString(num:sum))")
					.bold()
				Rectangle()
					.frame(width: 1, height: 500, alignment: .center)
					.foregroundColor(.gray)
			}
			
			VStack {
				ForEach(0..<(family == .systemLarge ? 7 : 3)){ i in
					if i < accounts.count {
					if !accounts.isEmpty	{
						if (!showAll && accounts[i].realAmount > 0.00) || showAll {
							
							if i != 0 {
								Divider()
								//							.padding(.vertical,-10)
							}
							
								WidgetAccountView(acct: $accounts[i] )
									.padding(.vertical,1)
							}
						}
						
					}
				}
			}
			.padding(.vertical, 6)
			.padding(.horizontal, family == .systemSmall ? 4 : 0)
		}
		.onAppear(){
//			WidgetCenter.shared.reloadAllTimelines()
			sum = 0
			accounts = getAccounts().sorted(by: {$0.realAmount > $1.realAmount})
			let byCrypto = UserDefaults.init(suiteName: "group.jtepp.Balance")!.bool(forKey: "byCrypto")
			if byCrypto {
				accounts.sort{$0.cryptoAmount > $1.cryptoAmount}
			}
			accounts.forEach { acct in
				if acct.cumulative.doubleValue > sum {
					sum = acct.cumulative.doubleValue
				}
			}
		}
	}
}
