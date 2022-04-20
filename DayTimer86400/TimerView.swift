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
    @Binding var isCenterText: Bool
    @Binding var isChangeFontSize: Bool
    @Binding var fontSizeVal: Double
    
    let daySecond = 24 * 60 * 60 * 1.0
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                if isCenterText {
                    Text("current day time")
                        .font(.title)
                } else {
                    HStack {
                        Text("  current day time")
                            .font(.title)
                        Spacer()
                    }
                }
                
                if isChangeFontSize {
                    Text("\(currentSecond, specifier: "%.0f") sec")
                        .font(.system(size: fontSizeVal, design:.default))
                } else {
                    Text("\(currentSecond, specifier: "%.0f") sec")
                        .font(.largeTitle)
                }
            }
            // 1秒に1回現在時刻を確認
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
                if isCenterText {
                    Text("  last day time")
                        .font(.title)
                } else {
                    HStack {
                        Text("  last day time")
                            .font(.title)
                        Spacer()
                    }
                }
                
                if isChangeFontSize {
                    Text("\(currentSecond, specifier: "%.0f") sec")
                        .font(.system(size: fontSizeVal, design:.default))
                } else {
                    Text("\(lastSecond, specifier: "%.0f") sec")
                        .font(.largeTitle)
                }
            }
            .padding()
            
            Spacer()
            
            VStack {
                if isCenterText {
                    Text("  view of %  ")
                        .font(.title)
                } else {
                    HStack {
                        Text("  view of %  ")
                            .font(.title)
                        Spacer()
                    }
                }
                if isChangeFontSize {
                    Text("\(currentSecond, specifier: "%.0f") sec")
                        .font(.system(size: fontSizeVal, design:.default))
                } else {
                    Text("\(lastSecond / daySecond * 100, specifier: "%.3f") %")
                        .font(.largeTitle)
                }
            }
            .padding()
            Spacer()
        }
        .foregroundColor(Color.textColor)
    }
}



struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(isCenterText: .constant(false), isChangeFontSize: .constant(false), fontSizeVal: .constant(40.0))
    }
}

