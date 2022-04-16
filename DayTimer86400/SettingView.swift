//
//  SettingView.swift
//  DayTimer86400
//  
//  Created by Funa on 2022/04/16
//  
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Text("設定！！！！")
                }
                .foregroundColor(Color.textColor)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
