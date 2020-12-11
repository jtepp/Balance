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
		ScrollView {
			HStack {
				Text("Settings")
					.font(.system(.largeTitle, design: .rounded))
					.bold()
					.padding()
					
				Spacer()
			}
			
			Toggle("Show assets with $0.00", isOn: $showAll)
				.font(.system(.body, design: .rounded))
				.onChange(of: showAll){ _ in
					UserDefaults.standard.set(showAll, forKey: "showAll")
				}
				.padding()
				
		}
	}
}
