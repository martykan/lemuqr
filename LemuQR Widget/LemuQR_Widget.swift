//
//  LemuQR_Widget.swift
//  LemuQR Widget
//
//  Created by Tomáš Martykán on 20.05.2022.
//

import WidgetKit
import SwiftUI
import Intents

// - MARK: Provider
struct Provider: IntentTimelineProvider {
    func getEntry(for configuration: SelectQROptionIntent) -> LemuQREntry {
        var image: UIImage? = nil
        if let _imageData = configuration.selectedQR?.imageData {
            image = UIImage(data: Data(base64Encoded: _imageData)!)
        }
        image = image ?? UIImage(named: "ExampleQR")
        return LemuQREntry(image: image, date: Date(), configuration: configuration)
    }

    func placeholder(in context: Context) -> LemuQREntry {
        return getEntry(for: SelectQROptionIntent())
    }
    
    func getSnapshot(for configuration: SelectQROptionIntent, in context: Context, completion: @escaping (LemuQREntry) -> ()) {
        completion(getEntry(for: configuration))
    }

    func getTimeline(for configuration: SelectQROptionIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [LemuQREntry] = [getEntry(for: configuration)]
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())!
        let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
        completion(timeline)
    }
}

struct LemuQREntry: TimelineEntry {
    let image: UIImage?
    let date: Date
    let configuration: SelectQROptionIntent
}

// - MARK: Widget View
struct LemuQR_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Image(uiImage: entry.image!)
            .resizable()
            .scaledToFill()
    }
}
struct LemuQR_Widget_Previews: PreviewProvider {
    static var previews: some View {
        let image = UIImage(named: "ExampleQR")
        LemuQR_WidgetEntryView(entry: LemuQREntry(image: image, date: Date(), configuration: SelectQROptionIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

// - MARK: Widget Configuration
@main
struct LemuQR_Widget: Widget {
    let kind: String = "LemuQR Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SelectQROptionIntent.self, provider: Provider()) { entry in
            LemuQR_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Code widget")
        .description("This widget shows a chosen code.")
        .supportedFamilies([.systemSmall, .systemLarge])
    }
}
