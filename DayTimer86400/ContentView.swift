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
    var body: some View {
        NavigationView {
            ZStack{
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                TimerView()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                
                            }){
                                Image(systemName: "gear")
                                    .foregroundColor(Color.textColor)
                            }
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
