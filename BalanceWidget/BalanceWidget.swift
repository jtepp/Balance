//
//  BalanceWidget.swift
//  BalanceWidget
//
//  Created by Jacob Tepperman on 2020-12-09.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
	func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
		let entry = SimpleEntry(date: Date())
		completion(entry)
	}
	
	func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
		var entries: [SimpleEntry] = []
		
		// Generate a timeline consisting of five entries an hour apart, starting from the current date.
		let currentDate = Date()
		for hourOffset in 0 ..< 5 {
			let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
			let entry = SimpleEntry(date: entryDate)
			entries.append(entry)
		}
		
		let timeline = Timeline(entries: entries, policy: .atEnd)
		completion(timeline)
	}
	
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }


}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct BalanceWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct BalanceWidget: Widget {
    let kind: String = "BalanceWidget"

    var body: some WidgetConfiguration {
		StaticConfiguration(kind: kind, provider: Provider()){ _ in
			MediumWidgetView()
		}
        .configurationDisplayName("Balance Widget")
		.description("Display all your Coinbase Balances on your home screen")
//		.supportedFamilies([WidgetFamily.systemMedium])
    }
}

struct BalanceWidget_Previews: PreviewProvider {
    static var previews: some View {
        BalanceWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}