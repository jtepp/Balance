//
//  WidgetAccountView.swift
//  BalanceWidgetExtension
//
//  Created by Jacob Tepperman on 2020-12-10.
//

import SwiftUI
import WidgetKit

struct WidgetAccountView: View {
	@Binding var acct: Account
	@Environment(\.widgetFamily) var family
	var body: some View {
		HStack{
			acct.image
				.resizable()
				.frame(width: 30, height: 30, alignment: .center)
				.aspectRatio(contentMode: .fit)
				.contentShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
				.minimumScaleFactor(0.5)
			
			HStack {
				
				Text(acct.cryptoName)
					.fontWeight(.bold)
					.font(.system(.headline, design: .rounded))
					.minimumScaleFactor(0.5)
				Spacer()
				VStack (alignment: .trailing){
					Text("$"+moneyString(num: acct.realAmount))
						.minimumScaleFactor(0.6)
						.font(.system(.headline, design: .rounded))
						
					Text(String(acct.cryptoAmount) + (family == .systemSmall ? "" : " \(acct.cryptoName)"))
						.minimumScaleFactor(0.01)
						.font(.system(.caption2, design: .rounded))

						
						
				}
			}
			
			Spacer()
		}
	}
}
