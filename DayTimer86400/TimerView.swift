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
                
                Text("\(String(saveTimerDate.year))/\(saveTimerDate.month)/\(saveTimerDate.day) \(saveTimerDate.hour):\(saveTimerDate.minute)")
                    .font(.custom("Futura", size: 30))
                    .foregroundColor(Color.white)
                
                Text(String(format:"%.0f", timerSecond) + " sec")
                    .font(.custom("Futura", size: 50))
                    .foregroundColor(Color.textColor)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("Change Date")
                        .font(.title)
                        .frame(width: 200, height: 80)
                        .imageScale(.large)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                }
                
                Spacer()
            }
            // 0.1秒に1回現在時刻を確認
            .onReceive(timer){ _ in
                timerSecond = abs(timerCount())
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
