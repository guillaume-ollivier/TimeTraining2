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
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Fond de la barre
                Capsule().fill(Color.secondary.opacity(0.2))
                
                // Barre de progression
                Capsule()
                    .fill(LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing))
                    .frame(width: geometry.size.width * CGFloat(progressRate))
                    .animation(.linear, value: progressRate)
                
                HStack {
                    Text("\(elapseTime.minute):\(elapseTime.second)")
                    Spacer()
                    Text("-\(remainTime.minute):\(remainTime.second)")
                }
                .font(.system(.subheadline, design: .monospaced).bold())
                .padding(.horizontal, 15)
                .foregroundColor(.primary)
            }
        }
    }
}

#Preview {
    TimeProgressView(elapseTime: HMSTime(from: 1),
                     remainTime: HMSTime(from: 2),
                     progressRate: 0.25)
}
