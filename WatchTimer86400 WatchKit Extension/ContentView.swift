//
//  ContentView.swift
//  WatchTimer86400 WatchKit Extension
//  
//  Created by Funa on 2022/05/04
//  
//

import SwiftUI


extension Color {
    static let textColor = Color("TextColor")
}

struct ContentView: View {
    @State private var nowDate = Date()
    @State private var currentSecond = 0.0
    @State private var lastSecond = 0.0
    private let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    func refreshCounter() {
        nowDate = Date()
        currentSecond = Double(nowDate.hour * 60 * 60 + nowDate.minute * 60 + nowDate.second)
        lastSecond = 24 * 60 * 60 - currentSecond
        
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("current day time")
                    .fontWeight(.thin)
                    .padding(.leading)
                Spacer()
            }
            Text("\(currentSecond, specifier: "%.0f") sec")
                .font(.title2)
            HStack {
                Text("last day time")
                    .fontWeight(.thin)
                    .padding(.leading)
                Spacer()
            }
            Text("\(lastSecond, specifier: "%.0f") sec")
                .font(.title2)
            HStack {
                Text("view of %")
                    .fontWeight(.thin)
                    .padding(.leading)
                Spacer()
            }
            Text("\(lastSecond / 86400 * 100, specifier: "%.3f") %")
                .font(.title2)
        }
        .foregroundColor(Color.textColor)
        // 1秒に1回現在時刻を確認
        .onReceive(timer){ _ in
            refreshCounter()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
