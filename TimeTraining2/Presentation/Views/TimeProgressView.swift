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
    let cornerRadius: CGFloat = 12 // Un arrondi plus moderne que la capsule
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Fond de la barre
                Capsule()
//                RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.secondary.opacity(0.2))
                // Barre de progression
                Capsule()
//                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing))
                    .frame(width: geometry.size.width * CGFloat(progressRate))
                    .animation(.linear, value: progressRate)
                
                HStack {
                    Text("\(elapseTime.minute):\(elapseTime.second)")
                        .font(.title).bold()
                    Spacer()
                    Text("-\(remainTime.minute):\(remainTime.second)")
                        .font(.title).bold()
                }
                .font(.system(.subheadline, design: .monospaced).bold())
                
                .padding(.horizontal, 15)
                .foregroundColor(.primary)
            }
            //.clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .clipShape(Capsule())
        }
    }
}

#Preview {
    TimeProgressView(elapseTime: HMSTime(from: 1),
                     remainTime: HMSTime(from: 2),
                     progressRate: 0.25)
}
