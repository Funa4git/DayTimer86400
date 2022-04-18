//
//  TimerView.swift
//  DayTimer86400
//  
//  Created by Funa on 2022/04/16
//  
//

import SwiftUI

struct TimerView: View {
    @State var hour = Calendar.current.component(.hour, from: Date())
    @State var minute = Calendar.current.component(.minute, from: Date())
    @State var second = Calendar.current.component(.second, from: Date())
    @State var currentSecond = 0.0
    @State var lastSecond = 24 * 60 * 60 * 1.0
    let daySecond = 24 * 60 * 60 * 1.0
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("current day time")
                    .font(.title)
                HStack {
                    Text("\(currentSecond, specifier: "%.0f")")
                    Text("sec")
                }
                .font(.largeTitle)
            }
            .onReceive(timer){ _ in
                self.hour = Calendar.current.component(.hour, from: Date())
                self.minute = Calendar.current.component(.minute, from: Date())
                self.second = Calendar.current.component(.second, from: Date())
                
                self.currentSecond = Double(hour * 60 * 60 + minute * 60 + second)
                self.lastSecond = daySecond - currentSecond
            }
            .padding()
            
            Spacer()
            
            VStack {
                Text("last day time")
                    .font(.title)
                HStack {
                    Text("\(lastSecond, specifier: "%.0f")")
                    Text("sec")
                }
                .font(.largeTitle)
            }
            .padding()
            
            Spacer()
            
            VStack {
                Text("view of %")
                    .font(.title)
                HStack {
                    Text("\(currentSecond / daySecond * 100, specifier: "%.3f")")
                    Text("%")
                }
                .font(.largeTitle)
            }
            .padding()
            Spacer()
        }
        .foregroundColor(Color.textColor)
    }
}

