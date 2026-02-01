//
//  ChronoView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 01/02/2026.
//

import SwiftUI

struct ChronoView: View {
    let elapseTime: HMSTime
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let iconSize = height * 0.8
            let spacing: CGFloat = 8
            
            HStack(spacing: spacing) {
                // Icône proportionnelle et rouge
                Image(systemName: "clock")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(.red)
                
                // Numéro de l'itération
                Text("\(elapseTime.toString())")
                    .font(.system(size: height, weight: .bold, design: .rounded))
                    .foregroundColor(.red)
                    .minimumScaleFactor(0.5) // Évite que le texte disparaisse si le segment est trop petit
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    ChronoView(elapseTime: HMSTime(from: 2)).frame(height: 60)
}
