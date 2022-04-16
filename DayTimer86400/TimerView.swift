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
            Text("current day time")
            Text("50787 sec")
            
            Text("last day time")
            Text("35613 sec")
            
            Text("view of %")
            Text("41.219 %")
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
