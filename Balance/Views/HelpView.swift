//
//  HelpView.swift
//  Balance
//
//  Created by Jacob Tepperman on 2020-12-11.
//

import SwiftUI

struct HelpView: View {
	var body: some View {
		
		VStack	{
			Text("It appears something went wrong with the server")
				.font(.system(.headline, design: .rounded))
			Text("Make sure you put in you API key & secret, and that 48 hours have passed since you created them.")
				.font(.system(.caption, design: .rounded))
		}
			.multilineTextAlignment(.center)
			.foregroundColor(.white)
			.padding()
			.background(
				RoundedRectangle(cornerRadius: 8)
					.foregroundColor(Color("coinbase"))
					.shadow(radius: 4)
					.frame(width: UIScreen.main.bounds.width-20)
			)
		
	}
}
