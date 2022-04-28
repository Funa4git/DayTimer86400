//
//  StopwatchView.swift
//  DayTimer86400
//  
//  Created by Funa on 2022/04/27
//  
//

import SwiftUI

struct StopwatchView: View {
    @AppStorage("startStopwatchKey") var startStopwatch = Date()
    @AppStorage("isStopwatchRunningKey") var isStopwatchRunning = false
    @AppStorage("countStopwatchKey") var saveCounter = 0.0
    
    private let timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    @State private var nowDate = Date()
    @State private var viewSecond = 0.0
    
    // 直近でスタートボタンが押された時刻を記録
    func saveStartTimer() {
        startStopwatch = Date()
    }
    // カウンター
    func fetchCount() -> Double {
        nowDate = Date()
        return saveCounter + nowDate.timeIntervalSince(startStopwatch)
    }
    // ボタンが押された時の関数
    func pushStart() {
        saveStartTimer()
        isStopwatchRunning = true
    }
    func pushStop() {
        isStopwatchRunning = false
        // saveCounterの更新はここのみで行うこと。
        saveCounter = fetchCount()
    }
    func pushReset() {
        saveCounter = 0
        // リセットボタンを押したときに即座に表示を0にする
        viewSecond = 0
        isStopwatchRunning = false
    }
    
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text(String(format:"%.0f", viewSecond))
                    .font(.custom("Futura", size: 50))
                    .foregroundColor(Color.textColor)
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        pushReset()
                    }) {
                        Text("Reset")
                            .font(.title)
                            .frame(width: 100, height: 100)
                            .imageScale(.large)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    Spacer()
                    Button(action: {
                        if isStopwatchRunning {
                            pushStop()
                        } else {
                            pushStart()
                        }
                    }) {
                        if isStopwatchRunning {
                            Text("Stop")
                                .font(.title)
                                .frame(width: 100, height: 100)
                                .imageScale(.large)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        } else {
                            Text("Start")
                                .font(.title)
                                .frame(width: 100, height: 100)
                                .imageScale(.large)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                    }
                    Spacer()
                }
                
                Spacer()
            }
            // 0.1秒に1回現在時刻を確認
            .onReceive(timer){ _ in
                if isStopwatchRunning {
                    viewSecond = fetchCount()
                } else {
                    viewSecond = saveCounter
                }
            }
        }
    }
}


struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
    }
}
