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
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                TimerView()
//                    .toolbar {
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            NavigationLink(destination: SettingView()) {
//                                VStack {
//                                    Image(systemName: "gear")
//                                        .foregroundColor(Color.textColor)
//                                }
//                            }
//                        }
//                    }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
