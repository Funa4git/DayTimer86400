//
//  WidgetTimer86400.swift
//  WidgetTimer86400Extension
//  
//  Created by Funa on 2022/04/20
//  
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), nowHour: 0, nowMinute: 0, nowSecond: 0, currentSecond: 0.0, lastSecond: 0.0, configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), nowHour: 0, nowMinute: 0, nowSecond: 0, currentSecond: 0.0, lastSecond: 0.0, configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entryHour = Calendar.current.component(.hour, from: Date())
            let entryMinute = Calendar.current.component(.minute, from: Date())
            let entrySecond = 0
            let entryCurrentSecond = Double(entryHour * 60 * 60 + entryMinute * 60 + entrySecond)
            let entryLastSecond = Double(24 * 60 * 60 - entryCurrentSecond)
            let entry = SimpleEntry(date: entryDate, nowHour: entryHour, nowMinute: entryMinute, nowSecond: entrySecond, currentSecond: entryCurrentSecond, lastSecond: entryLastSecond, configuration: configuration)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let nowHour: Int
    let nowMinute: Int
    let nowSecond: Int
    let currentSecond: Double
    let lastSecond: Double
    let configuration: ConfigurationIntent
}

// 色の設定
extension Color {
    static let textColor = Color("TextColor")
    static let backgroundColor = Color("BackgroundColor")
}

struct WidgetTimer86400EntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Text(" \(entry.currentSecond, specifier: "%.0f") sec")
                        .padding(.trailing)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    Text("+ \(entry.lastSecond, specifier: "%.0f") sec")
                        .padding(.trailing)
                }
                
                Spacer()
                
                HStack {
                    Text("残り")
                        .fontWeight(.bold)
                        .padding(.leading)
                    Spacer()
                    Text("\(entry.lastSecond / (24 * 60 * 60) * 100, specifier: "%.0f") %")
                        .fontWeight(.bold)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .foregroundColor(Color.textColor)
        }
    }
}


@main

struct WidgetTimer86400: Widget {
    let kind: String = "WidgetTimer86400"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetTimer86400EntryView(entry: entry)
        }
        .configurationDisplayName("86400")
        .description("One day is 86400 seconds.")
        .supportedFamilies([.systemSmall])
    }
}

struct WidgetTimer86400_Previews: PreviewProvider {
    static var previews: some View {
        WidgetTimer86400EntryView(entry: SimpleEntry(date: Date(), nowHour: 0, nowMinute: 0, nowSecond: 0, currentSecond: 0.0, lastSecond: 24 * 60 * 60.0, configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
