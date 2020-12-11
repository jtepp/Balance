//
//  Home.swift
//  Balance
//
//  Created by Jacob Tepperman on 2020-12-09.
//

import SwiftUI
import WidgetKit

struct Home: View {
	@Binding var accts: [Account]
	@State var byCAD = true
	@State var sum = Double()
	var body: some View {
		HStack	{
			Text("$\(moneyString(num:sum))")
				.font(.system(.largeTitle, design: .rounded))
			.bold()
			.padding(.top)
				.padding(.horizontal)
			Spacer()
		}
		HStack	{
			Text("Sort:")
				.padding(.leading, 20)
				.padding(.trailing, 0)
			Picker(selection: $byCAD, label: Text("Sort")){
				Text("CAD").tag(true)
				Text("Crypto").tag(false)
			}
			.onChange(of: byCAD, perform: { _ in
				if byCAD {
					accts.sort(by: { $0.realAmount > $1.realAmount})
				} else {
					accts.sort(by: { $0.cryptoAmount > $1.cryptoAmount})
				}
			})
			.pickerStyle(SegmentedPickerStyle())
			.padding(.leading)
			
			Button(action: {
				sum = 0
				accts = getAccounts()
				if byCAD {
					accts.sort(by: { $0.realAmount > $1.realAmount})
				} else {
					accts.sort(by: { $0.cryptoAmount > $1.cryptoAmount})
				}
				accts.forEach { acct in
					if acct.cumulative.doubleValue > sum {
						sum = acct.cumulative.doubleValue
					}
				}
				WidgetCenter.shared.reloadAllTimelines()
			}){
				Image(systemName: "arrow.counterclockwise.circle.fill")
					.resizable()
					.frame(width: 30, height: 30)
					.foregroundColor(Color("coinbase"))
					.background(
						Circle()
							.padding(3)
							.foregroundColor(.white)
					)
					.padding(.horizontal)
					
					
					
			}
		}
		
		ForEach(accts.indices, id: \.self) { index in
//			if index != 0 {
				Divider()
//			}
			AccountView(acct: $accts[index])
				.padding(.vertical)
				.padding(.horizontal)
		}
		
		.onAppear{
			sum = 0
			accts = getAccounts()
			if byCAD {
				accts.sort(by: { $0.realAmount > $1.realAmount})
			} else {
				accts.sort(by: { $0.cryptoAmount > $1.cryptoAmount})
			}
			accts.forEach { acct in
				if acct.cumulative.doubleValue > sum {
					sum = acct.cumulative.doubleValue
				}
			}
			WidgetCenter.shared.reloadAllTimelines()
		}
		
	}
	
}
