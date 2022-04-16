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
    let daySecond = 24*60*60
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("current day time")
                    .font(.title)
                HStack {
                    Text("\(hour*60*60 + minute*60 + second)")
                    Text("sec")
                }
                .font(.largeTitle)
            }
            .onReceive(timer){ _ in
                self.hour = Calendar.current.component(.hour, from: Date())
                self.minute = Calendar.current.component(.minute, from: Date())
                self.second = Calendar.current.component(.second, from: Date())
            }
            .padding()
            VStack {
                Text("last day time")
                    .font(.title)
                HStack {
                    Text("\(daySecond - (hour*60*60 + minute*60 + second))")
                    Text("sec")
                }
                .font(.largeTitle)
            }
            .padding()
            VStack {
                Text("view of %")
                    .font(.title)
                HStack {
                    Text("\(100 * (hour*60*60 + minute*60 + second) / daySecond)")
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

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
