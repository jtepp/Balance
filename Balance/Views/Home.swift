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
	@Binding var showAll: Bool
	@State var byCAD = true
	@State var sum = Double()
	@Binding var showHelp:Bool
	@State var showSettings = false
	var body: some View {
		if !showSettings {
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
				if accts == [Account.empty] || accts.isEmpty {
					showHelp = true
				} else { showHelp = false }
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
		if showHelp {
			
			Button{
				showSettings = true
			} label:{
			HelpView()
				
			}

		}
		ForEach(accts.indices, id: \.self) { index in
			if (!showAll && accts[index].realAmount > 0.00) || showAll && accts != [Account.empty] && !accts.isEmpty{
				
			
//			if index != 0 {
				Divider()
//			}
			AccountView(acct: $accts[index])
				.padding(.vertical)
				.padding(.horizontal)
			}
		}

		.accentColor(Color("coinbase"))
		.onAppear{
			sum = 0
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
		
		
		} else {
			Details()
			Button {
				showSettings = false
			} label: {
				Text("Dismiss")

		}
		}
	}
	
}
