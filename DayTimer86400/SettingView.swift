//
//  SettingView.swift
//  DayTimer86400
//  
//  Created by Funa on 2022/04/16
//  
//

import SwiftUI

struct SettingView: View {
    @Binding var isCenterText: Bool
    @Binding var isChangeFontSize: Bool
    @Binding var fontSizeVal: Double
    
    var body: some View {
        ZStack {
            Form {
                Section {
                    Toggle(isOn: $isCenterText) {
                        Text("中央揃え")
                    }
                    Toggle(isOn: $isChangeFontSize) {
                        Text("文字サイズを変更")
                    }
                    if isChangeFontSize {
                        VStack {
                            Text("\(fontSizeVal, specifier: "%.0f")")
                            Slider(value: $fontSizeVal, in: 10...100, step: 5)
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.inline/*@END_MENU_TOKEN@*/)
    }
}

