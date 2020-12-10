//
//  MediumWidgetView.swift
//  Balance
//
//  Created by Jacob Tepperman on 2020-12-09.
//

import SwiftUI
import WidgetKit

struct BasicWidgetView: View {
	@State var accounts: [Account]
	@State var sum = 0
	var body: some View {
		ForEach(0..<3){ i in
			if i != 0 {
				Divider()
					.padding(.vertical,0)
			}
			GeneralWidgetView(acct: $accounts[i])
				.padding(.vertical,-5)
		}
		.onAppear(){
			WidgetCenter.shared.reloadAllTimelines()
		}
	}
}
