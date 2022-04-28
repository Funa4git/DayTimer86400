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
    
    @Binding var isChangeFontSize: Bool
    @Binding var fontSizeVal: Double
    
    private let timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    @State private var nowDate = Date()
    @State private var stopwatchSecond = 0.0
    
    // 直近でスタートボタンが押された時刻を記録
    private func saveStartTimer() {
        startStopwatch = Date()
    }
    // カウンター
    private func fetchCount() -> Double {
        nowDate = Date()
        return saveCounter + nowDate.timeIntervalSince(startStopwatch)
    }
    // ボタンが押された時の関数
    private func pushStart() {
        saveStartTimer()
        isStopwatchRunning = true
    }
    private func pushStop() {
        isStopwatchRunning = false
        // saveCounterの更新はここのみで行うこと。
        saveCounter = fetchCount()
    }
    private func pushReset() {
        saveCounter = 0
        // リセットボタンを押したときに即座に表示を0にする
        stopwatchSecond = 0
        isStopwatchRunning = false
    }
    
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                if isChangeFontSize {
                    Text("\(stopwatchSecond, specifier: "%.0f") sec")
                        .font(.custom("Futura", size: fontSizeVal))
                        .foregroundColor(Color.textColor)
                } else {
                    Text("\(stopwatchSecond, specifier: "%.0f") sec")
                        .font(.custom("Futura", size: 50))
                        .foregroundColor(Color.textColor)
                }
                
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
                    stopwatchSecond = fetchCount()
                } else {
                    stopwatchSecond = saveCounter
                }
            }
        }
    }
}


struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView(isChangeFontSize: .constant(false), fontSizeVal: .constant(40.0))
    }
}
