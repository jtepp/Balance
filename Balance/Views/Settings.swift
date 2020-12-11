//
//  Settings.swift
//  Balance
//
//  Created by Jacob Tepperman on 2020-12-10.
//

import SwiftUI

struct Settings: View {
	@Binding var showAll: Bool
	var body: some View {
		NavigationView	{
			ScrollView {
				
				
				Toggle("Show assets with $0.00", isOn: $showAll)
					.font(.system(.body, design: .rounded))
					.onChange(of: showAll){ _ in
						UserDefaults.standard.set(showAll, forKey: "showAll")
					}
					.padding()
				NavigationLink(destination: Details()){
					Text("API Configuration")
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
			.accentColor(Color("coinbase"))
			.navigationTitle("Settings")
		}
	}
}
