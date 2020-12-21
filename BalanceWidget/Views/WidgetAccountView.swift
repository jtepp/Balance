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
				VStack(alignment: .leading) {
					Text(acct.cryptoName)
						.fontWeight(.bold)
						.font(.system(.headline, design: .rounded))
						.minimumScaleFactor(0.5)
					Text("@\(moneyString(num:acct.buy.doubleValue))")
						.minimumScaleFactor(0.01)
						.font(.system(.caption2, design: .rounded))
				}
				Spacer()
				VStack (alignment: .trailing){
					Text("$"+moneyString(num: acct.realAmount))
						.minimumScaleFactor(0.6)
						.font(.system(.headline, design: .rounded))
						
					Text((family == .systemSmall ? String(acct.cryptoAmount).truncated(limit: 5) : String(acct.cryptoAmount)) + (family == .systemSmall ? "" : " \(acct.cryptoName)"))
						.minimumScaleFactor(0.05)
						.font(.system(.caption2, design: .rounded))

						
						
				}
			}
			
			Spacer()
		}
	}
}

extension String {
	enum TruncationPosition {
		case head
		case middle
		case tail
	}
	
	func truncated(limit: Int, position: TruncationPosition = .tail, leader: String = "...") -> String {
		guard self.count > limit else { return self }
		
		switch position {
			case .head:
				return leader + self.suffix(limit)
			case .middle:
				let headCharactersCount = Int(ceil(Float(limit - leader.count) / 2.0))
				
				let tailCharactersCount = Int(floor(Float(limit - leader.count) / 2.0))
				
				return "\(self.prefix(headCharactersCount))\(leader)\(self.suffix(tailCharactersCount))"
			case .tail:
				return self.prefix(limit) + leader
		}
	}
}
