//
//  StopwatchView.swift
//  DayTimer86400
//  
//  Created by Funa on 2022/04/27
//  
//

import SwiftUI

struct StopwatchView: View {
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        // Do something
                    }) {
                        Text("Start")
                            .frame(width: 60, height: 60)
                            .imageScale(.large)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    Spacer()
                    Button(action: {
                        // Do something
                    }) {
                        Text("Stop")
                            .frame(width: 60, height: 60)
                            .imageScale(.large)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    Spacer()
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
