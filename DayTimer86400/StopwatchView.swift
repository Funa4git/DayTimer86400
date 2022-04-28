//
//  StopwatchView.swift
//  DayTimer86400
//  
//  Created by Funa on 2022/04/27
//  
//

import SwiftUI

struct StopwatchView: View {
    @State var nowDate = Date()
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text(String(format:"%.0f", 11.25))
                        .font(.custom("Futura", size: 50))
                
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Start")
                            .font(.title)
                            .frame(width: 100, height: 100)
                            .imageScale(.large)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Stop")
                            .font(.title)
                            .frame(width: 100, height: 100)
                            .imageScale(.large)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                
                Spacer()
            }
            // 1秒に1回現在時刻を確認
            .onReceive(timer){ _ in
                
            }
        }
    }
}


struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
    }
}
