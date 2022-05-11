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
        SimpleEntry(date: Date(), currentSecond: 0.0, lastSecond: 24 * 60 * 60.0, configuration: ConfigurationIntent(), displaySize: context.displaySize)
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let snapDate = Date()
        let snapCurrentSecond = Double((snapDate.hour * 60 * 60) + (snapDate.minute * 60) + 0)
        let snapLastSecond = Double(24 * 60 * 60 - snapCurrentSecond)
        
        let entry = SimpleEntry(date: Date(), currentSecond: snapCurrentSecond, lastSecond: snapLastSecond, configuration: configuration, displaySize: context.displaySize)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        // 15分間隔での更新要求のDate()
        let futureDate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!
        // 15 min * 12 times = 3 hours
        for hourOffset in 0 ..< 12 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entryCurrentSecond = Double((entryDate.hour * 60 * 60) + (entryDate.minute * 60) + 0)
            let entryLastSecond = Double(24 * 60 * 60 - entryCurrentSecond)
            let entry = SimpleEntry(date: entryDate, currentSecond: entryCurrentSecond, lastSecond: entryLastSecond, configuration: configuration, displaySize: context.displaySize)
            entries.append(entry)
        }
        // 更新タイムラインの申請
        let timeline = Timeline(entries: entries, policy: .after(futureDate))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let currentSecond: Double
    let lastSecond: Double
    let configuration: ConfigurationIntent
    let displaySize: CGSize
}

// 色の設定
extension Color {
    static let textColor = Color("TextColor")
    static let backgroundColor = Color("BackgroundColor")
}

struct WidgetTimer86400EntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        switch family {
        case .systemSmall:
            smallView()
        case .systemMedium:
            mediumView()
        case .systemLarge:
            largeView()
        case .systemExtraLarge:
            extraLargeView()
        default:
            smallView()
        }
    }
    
    
    func smallView() -> some View {
            return ZStack {
                Color.textColor
                
                Color.black
                    .frame(width: .infinity, height: entry.displaySize.height*(1-(entry.lastSecond/(24*60*60))))
                    .position(x: entry.displaySize.width/2, y: entry.displaySize.height*(1-(entry.lastSecond/(24*60*60)))/2)
                
                VStack {
                    Spacer()
                    
                    Text("本日残り")
                        .font(.system(.largeTitle, design: .serif))
                        .fontWeight(.bold)
                    
                    Text("\(entry.lastSecond / (24 * 60 * 60) * 100, specifier: "%.0f") %")
                        .font(.system(.largeTitle, design: .serif))
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .foregroundColor(Color.white)
            }
    }
    
    func mediumView() -> some View {
            return ZStack {
                Color.textColor
                
                Color.black
                    .frame(width: .infinity, height: entry.displaySize.height*(1-(entry.lastSecond/(24*60*60))))
                    .position(x: entry.displaySize.width/2, y: entry.displaySize.height*(1-(entry.lastSecond/(24*60*60)))/2)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            Text("Today's")
                                .font(.system(.title2, design: .serif))
                                .fontWeight(.bold)
                            
                            Text("")
                            
                            Text("Remaining")
                                .font(.system(.title2, design: .serif))
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                        
                        Text("\(entry.lastSecond / (24 * 60 * 60) * 100, specifier: "%.0f") %")
                            .font(.system(size: 45, weight: .bold, design: .serif))
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .foregroundColor(Color.white)
            }
    }
    
    func largeView() -> some View {
            return ZStack {
                Color.textColor
                
                Color.black
                    .frame(width: .infinity, height: entry.displaySize.height*(1-(entry.lastSecond/(24*60*60))))
                    .position(x: entry.displaySize.width/2, y: entry.displaySize.height*(1-(entry.lastSecond/(24*60*60)))/2)
                
                VStack {
                    Spacer()
                    
                    Text("Today's")
                        .font(.system(size: 45, weight: .bold, design: .serif))
                        .fontWeight(.bold)
                    
                    Text("")
                    
                    Text("Remaining")
                        .font(.system(size: 45, weight: .bold, design: .serif))
                        .fontWeight(.bold)
                    
                    Text("")
                    
                    Text("\(entry.lastSecond / (24 * 60 * 60) * 100, specifier: "%.0f") %")
                        .font(.system(size: 60, weight: .bold, design: .serif))
                    
                    Spacer()
                }
                .foregroundColor(Color.white)
            }
    }
    
    func extraLargeView() -> some View {
        return ZStack {
            Color.textColor
            
            Color.black
                .frame(width: .infinity, height: entry.displaySize.height*(1-(entry.lastSecond/(24*60*60))))
                .position(x: entry.displaySize.width/2, y: entry.displaySize.height*(1-(entry.lastSecond/(24*60*60)))/2)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack {
                        Text("Today's")
                            .font(.system(size: 55, weight: .bold, design: .serif))
                            .fontWeight(.bold)
                        
                        Text("")
                        
                        Text("Remaining")
                            .font(.system(size: 55, weight: .bold, design: .serif))
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    Text("\(entry.lastSecond / (24 * 60 * 60) * 100, specifier: "%.0f") %")
                        .font(.system(size: 70, weight: .bold, design: .serif))
                    
                    Spacer()
                }
                
                Spacer()
            }
            .foregroundColor(Color.white)
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
    }
}

struct WidgetTimer86400_Previews: PreviewProvider {
    static var previews: some View {
        WidgetTimer86400EntryView(entry: SimpleEntry(date: Date(), currentSecond: 0.0, lastSecond: 24 * 60 * 60.0, configuration: ConfigurationIntent(), displaySize: CGSize(width: 180, height: 180)))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
