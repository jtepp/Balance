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
		let entry = SimpleEntry(date: Date(), accounts: getAccounts().sorted{ $0.realAmount > $1.realAmount})
		completion(entry)
	}
	
	func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
		var entries: [SimpleEntry] = []
		
		// Generate a timeline consisting of five entries an hour apart, starting from the current date.

		let entryDate = Date(timeIntervalSinceNow: 0)
		var acctEntrance = getAccounts().sorted{ $0.realAmount > $1.realAmount}
		let byCrypto = UserDefaults.init(suiteName: "group.jtepp.Balance")!.bool(forKey: "byCrypto")
		if byCrypto {
			acctEntrance.sort{ $0.cryptoAmount > $1.cryptoAmount}
		}
			let entry = SimpleEntry(date: entryDate, accounts: acctEntrance)
			entries.append(entry)
		
		let next = Calendar.current.date(byAdding: .second, value: 30, to: Date(timeIntervalSinceNow: 0))!
		let timeline = Timeline(entries: entries, policy: .after(next))
		completion(timeline)
	}
	
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), accounts: [Account.empty,Account.empty,Account.empty])
    }


}

struct SimpleEntry: TimelineEntry {
    let date: Date
	let accounts:[Account]
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
		StaticConfiguration(kind: kind, provider: Provider()){ entry in
			WidgetView(accounts: entry.accounts)
		}
        .configurationDisplayName("Balance Widget")
		.description("Display all your Coinbase Balances on your home screen")
//		.supportedFamilies([WidgetFamily.systemMedium])
    }
}

struct BalanceWidget_Previews: PreviewProvider {
    static var previews: some View {
		BalanceWidgetEntryView(entry: SimpleEntry(date: Date(), accounts: [Account.empty,Account.empty,Account.empty]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
