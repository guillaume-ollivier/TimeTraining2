import SwiftUI

struct IterationProgressView: View {
    let iterations: [Float] // Tableau des durées (ex: [10, 30, 20])
    let currentIndex: Int   // L'index de l'étape active
    
    private var totalDuration: Float {
        // Évite la division par zéro si le tableau est vide
        max(iterations.reduce(0, +), 1)
    }

    var body: some View {
            GeometryReader { geometry in
                let height = geometry.size.height
                let iconSize = height * 0.8
                let spacing: CGFloat = 8
                
                HStack(spacing: spacing) {
                    // Icône proportionnelle et rouge
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: iconSize, height: iconSize)
                        .foregroundColor(.red)
                    
                    // Barre de progression avec numéros
                    HStack(spacing: 3) {
                        ForEach(0..<iterations.count, id: \.self) { index in
                            let isCompletedOrCurrent = index == currentIndex || currentIndex>=iterations.count
                            let segmentWidth = CGFloat(iterations[index] / totalDuration) * (geometry.size.width - iconSize - spacing)
                            
                            ZStack {
                                // Fond du segment
                                Rectangle()
                                    .fill(Color.secondary.opacity(0.2))
                                
                                // Remplissage actif
                                if isCompletedOrCurrent {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing))
                                        .transition(.opacity)
                                }
                                
                                // Numéro de l'itération
                                Text("\(index + 1)")
                                    .font(.system(size: height * 0.5, weight: .bold, design: .rounded))
                                    .foregroundColor(isCompletedOrCurrent ? .white : .secondary)
                                    .minimumScaleFactor(0.5) // Évite que le texte disparaisse si le segment est trop petit
                                    .lineLimit(1)
                            }
                            .frame(width: max(segmentWidth, 0))
                        }
                    }
                    .clipShape(Capsule())
                }
            }
            .animation(.easeInOut, value: currentIndex)
        }
    }

#Preview {
    VStack(spacing: 30) {
        // Exemple avec le deuxième segment actif (le plus long)
        IterationProgressView(iterations: [15, 45, 20], currentIndex: 0)
            .frame(height: 60)
            .padding()
        
        Text("Segment 2 actif (45s sur 80s total)")
            .font(.caption)
    }
}
