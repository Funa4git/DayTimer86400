//
//  TimerView.swift
//  DayTimer86400
//  
//  Created by Funa on 2022/04/28
//  
//

import SwiftUI

struct TimerView: View {
    @AppStorage("saveTimerDateKey") var saveTimerDate = Date()
    
    private let timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    @State private var nowDate = Date()
    @State private var timerSecond = 0.0
    @State private var isShowSheet = false
    
    @Binding var isChangeFontSize: Bool
    @Binding var fontSizeVal: Double
    
    func timerCount() -> Double {
        nowDate = Date()
        return saveTimerDate.timeIntervalSince(nowDate)
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Counting from")
                    .font(.custom("Futura", size: 30))
                    .foregroundColor(Color.white)
                
                Text("\(String(saveTimerDate.year))/\(saveTimerDate.month, specifier: "%02d")/\(saveTimerDate.day, specifier: "%02d") \(saveTimerDate.hour, specifier: "%02d"):\(saveTimerDate.minute, specifier: "%02d")")
                    .font(.custom("Futura", size: 30))
                    .foregroundColor(Color.white)
                
                if isChangeFontSize {
                    Text("\(timerSecond, specifier: "%.0f") sec")
                        .font(.system(size: fontSizeVal, design:.monospaced))
                        .foregroundColor(Color.textColor)
                        .padding()
                } else {
                    Text("\(timerSecond, specifier: "%.0f") sec")
                        .font(.system(size: 40, design:.monospaced))
                        .foregroundColor(Color.textColor)
                        .padding()
                }
                
                
                Spacer()
                
                Button(action: {
                    isShowSheet = true
                }) {
                    Text("Change Date")
                        .font(.title)
                        .frame(width: 200, height: 50)
                        .imageScale(.large)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                }
                .sheet(isPresented: $isShowSheet) {
                    VStack {
                        Spacer()
                        
                        Text("現在時刻から設定時刻までの秒数をリアルタイムで表示します。")
                            .font(.title)
                            .padding()
                        
                        DatePicker("設定時刻", selection: $saveTimerDate)
                            .labelsHidden()
                        
                        Spacer()
                    }
                }
                
                Spacer()
            }
            // 0.1秒に1回現在時刻を確認
            .onReceive(timer){ _ in
                if isShowSheet {
                    
                } else {
                    timerSecond = abs(timerCount())
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(isChangeFontSize: .constant(false), fontSizeVal: .constant(40.0))
    }
}
