//
//  TimeProgressView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 20/01/2026.
//

import SwiftUI

struct TimeProgressView: View {
    let elapseTime: HMSTime
    let remainTime: HMSTime
    let progressRate: Float
    
    var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { geometry in
                Capsule()
                    .fill(.red)
                    .frame(width: geometry.size.width * (CGFloat)(progressRate),
                           height: geometry.size.height)
            }
            HStack {
                Text(elapseTime.minute)
                Text(":")
                Text(elapseTime.second)
                Spacer()
                Text(remainTime.minute)
                Text(":")
                Text(remainTime.second)
            }.padding(20)
        }
    }
}

#Preview {
    TimeProgressView(elapseTime: HMSTime(from: 1),
                     remainTime: HMSTime(from: 2),
                     progressRate: 0.25)
}
