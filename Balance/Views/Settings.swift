//
//  Settings.swift
//  Balance
//
//  Created by Jacob Tepperman on 2020-12-10.
//

import SwiftUI

struct Settings: View {
	@Binding var showAll: Bool
	@State var byCrypto =  UserDefaults.init(suiteName: "group.jtepp.Balance")!.bool(forKey: "byCrypto")
	var body: some View {
		NavigationView	{
			ScrollView {
				
				
				Toggle("Show assets with $0.00", isOn: $showAll)
					.font(.system(.body, design: .rounded))
					.onChange(of: showAll){ _ in
						UserDefaults.init(suiteName: "group.jtepp.Balance")!.set(showAll, forKey: "showAll")
					}
					.padding()
				
				Toggle("Sort coins by crypto amounts", isOn: $byCrypto)
					.font(.system(.body, design: .rounded))
					.onChange(of: byCrypto){ _ in
						UserDefaults.init(suiteName: "group.jtepp.Balance")!.set(byCrypto, forKey: "byCrypto")
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
