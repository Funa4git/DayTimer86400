//
//  TimerView.swift
//  DayTimer86400
//  
//  Created by Funa on 2022/04/16
//  
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("current day time")
                    .font(.largeTitle)
                HStack {
                    Text("50787")
                    Text("sec")
                }
                .font(.title)
            }
            .padding()
            VStack {
                Text("last day time")
                    .font(.largeTitle)
                HStack {
                    Text("35613")
                    Text("sec")
                }
                    .font(.title)
            }
            .padding()
            VStack {
                Text("view of %")
                    .font(.largeTitle)
                HStack {
                    Text("41.219")
                    Text("%")
                }
                    .font(.title)
            }
            .padding()
            Spacer()
        }
        .foregroundColor(Color.textColor)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
