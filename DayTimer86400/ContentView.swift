//
//  ContentView.swift
//  DayTimer86400
//  
//  Created by Funa on 2022/04/16
//  
//

import SwiftUI

extension Color {
    static let textColor = Color("TextColor")
    static let backgroundColor = Color("BackgroundColor")
}

struct ContentView: View {
    @State var selectionDate = Date()
    @AppStorage("isCenterTextKey") var isCenterText = false
    @AppStorage("isChangeFontSizeKey") var isChangeFontSize = false
    @AppStorage("fontSizeValKey") var fontSizeVal : Double = 40.0
    
    var body: some View {
        TabView {
            NavigationView {
                ZStack {
                    Color.backgroundColor
                        .edgesIgnoringSafeArea(.all)
                    
                    TimerView(isCenterText: $isCenterText, isChangeFontSize: $isChangeFontSize, fontSizeVal: $fontSizeVal)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink(destination: SettingView(isCenterText: $isCenterText, isChangeFontSize: $isChangeFontSize, fontSizeVal: $fontSizeVal)) {
                                    VStack {
                                        Image(systemName: "gear")
                                            .foregroundColor(Color.textColor)
                                    }
                                }
                            }
                        }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(.stack)
            .tabItem({
                Image(systemName: "clock")
                Text("Clock")
            })
            
            NavigationView {
                StopwatchView()
            }
            .navigationViewStyle(.stack)
            .tabItem({
                Image(systemName: "stopwatch")
                Text("Stopwatch")
            })
            
            NavigationView {
                
            }
            .navigationViewStyle(.stack)
            .tabItem({
                Image(systemName: "timer")
                Text("Timer")
            })
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
