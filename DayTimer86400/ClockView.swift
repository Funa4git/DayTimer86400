//
//  TimerView.swift
//  DayTimer86400
//  
//  Created by Funa on 2022/04/16
//  
//

import SwiftUI

struct ClockView: View {
    @State var nowHour = Calendar.current.component(.hour, from: Date())
    @State var nowMinute = Calendar.current.component(.minute, from: Date())
    @State var nowSecond = Calendar.current.component(.second, from: Date())
    
    @State var currentSecond = 0.0
    @State var lastSecond = 24 * 60 * 60 * 1.0
    @Binding var isCenterText: Bool
    @Binding var isChangeFontSize: Bool
    @Binding var fontSizeVal: Double
    
    let daySecond = 24 * 60 * 60 * 1.0
    private let timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                if isCenterText {
                    Text("current day time")
                        .font(.custom("Futura", size: fontSizeVal*0.7, relativeTo: .title))
                } else {
                    HStack {
                        Text("  current day time")
                            .font(.custom("Futura", size: fontSizeVal*0.7, relativeTo: .title))
                        Spacer()
                    }
                }
                
                if isChangeFontSize {
                    Text("\(currentSecond, specifier: "%.0f") sec")
                        .font(.system(size: fontSizeVal, design:.monospaced))
                } else {
                    Text("\(currentSecond, specifier: "%.0f") sec")
                        .font(.system(.largeTitle, design: .monospaced))
                }
            }
            // 0.1秒に1回現在時刻を確認
            .onReceive(timer){ _ in
                self.nowHour = Calendar.current.component(.hour, from: Date())
                self.nowMinute = Calendar.current.component(.minute, from: Date())
                self.nowSecond = Calendar.current.component(.second, from: Date())
                
                self.currentSecond = Double(nowHour * 60 * 60 + nowMinute * 60 + nowSecond)
                self.lastSecond = daySecond - currentSecond
            }
            .padding()
            
            Spacer()
            
            VStack {
                if isCenterText {
                    Text("  last day time")
                        .font(.custom("Futura", size: fontSizeVal*0.7, relativeTo: .title))
                } else {
                    HStack {
                        Text("  last day time")
                            .font(.custom("Futura", size: fontSizeVal*0.7, relativeTo: .title))
                        Spacer()
                    }
                }
                
                if isChangeFontSize {
                    Text("\(lastSecond, specifier: "%.0f") sec")
                        .font(.system(size: fontSizeVal, design:.monospaced))
                } else {
                    Text("\(lastSecond, specifier: "%.0f") sec")
                        .font(.system(.largeTitle, design: .monospaced))
                }
            }
            .padding()
            
            Spacer()
            
            VStack {
                if isCenterText {
                    Text("  view of %  ")
                        .font(.custom("Futura", size: fontSizeVal*0.7, relativeTo: .title))
                } else {
                    HStack {
                        Text("  view of %  ")
                            .font(.custom("Futura", size: fontSizeVal*0.7, relativeTo: .title))
                        Spacer()
                    }
                }
                if isChangeFontSize {
                    Text("\(lastSecond / daySecond * 100, specifier: "%.3f") %")
                        .font(.system(size: fontSizeVal, design:.monospaced))
                } else {
                    Text("\(lastSecond / daySecond * 100, specifier: "%.3f") %")
                        .font(.system(.largeTitle, design: .monospaced))
                }
            }
            .padding()
            Spacer()
        }
        .foregroundColor(Color.textColor)
    }
}



struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(isCenterText: .constant(false), isChangeFontSize: .constant(false), fontSizeVal: .constant(40.0))
    }
}

