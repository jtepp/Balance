//
//  AccountView.swift
//  Balance
//
//  Created by Jacob Tepperman on 2020-12-09.
//

import SwiftUI

struct AccountView: View {
	@Binding var acct: Account
	
	var body: some View {
		HStack{
			acct.image
				.resizable()
				.frame(width: 45, height: 45, alignment: .center)
				.aspectRatio(contentMode: .fit)
				.contentShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
			
			HStack {
				VStack {
					Text(acct.cryptoName)
						.font(.system(.headline, design: .rounded))
						.bold()
					Text("@\(acct.buy)")
						.font(.system(.footnote, design: .rounded))
				}
				Spacer()
				VStack (alignment: .trailing){
				Text("$"+moneyString(num: acct.realAmount))
					.font(.system(.headline, design: .rounded))
				Text(String(acct.cryptoAmount)+" \(acct.cryptoName)")
					.font(.system(.footnote, design: .rounded))
				}
			}
			
			Spacer()
		}
	}
}
