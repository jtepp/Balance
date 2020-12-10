//
//  MediumWidgetView.swift
//  Balance
//
//  Created by Jacob Tepperman on 2020-12-09.
//

import SwiftUI
import WidgetKit

struct MediumWidgetView: View {
	@State var accounts = getAccounts().sorted{ $0.realAmount > $1.realAmount}
	var body: some View {
		ForEach(0..<3){ i in
			if i != 0 {
				Divider()
			}
			AccountView(acct: $accounts[i])
		}
		.onAppear(){
			WidgetCenter.shared.reloadAllTimelines()
		}
	}
}
