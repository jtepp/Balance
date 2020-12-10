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
				
				Text(acct.cryptoName)
				.fontWeight(.bold)
					.font(.headline)
				Spacer()
				VStack (alignment: .trailing){
				Text("$"+moneyString(num: acct.realAmount))
					.font(.headline)
				Text(String(acct.cryptoAmount)+" \(acct.cryptoName)")
					.font(.footnote)
				}
			}
			
			Spacer()
		}
	}
}
