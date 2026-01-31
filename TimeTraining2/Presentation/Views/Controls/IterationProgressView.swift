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
            HStack(spacing: 3) { // Un léger espacement pour bien distinguer les segments
                ForEach(0..<iterations.count, id: \.self) { index in
                    let segmentWidth = CGFloat(iterations[index] / totalDuration) * geometry.size.width
                    
                    ZStack {
                        // Fond commun pour tous les segments
                        Rectangle()
                            .fill(Color.secondary.opacity(0.2))
                        
                        // Segment actif : plein à 100%
                        if index == currentIndex || currentIndex>=iterations.count{
                            Rectangle()
                                .fill(LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing))
                                // Une transition fluide lors du changement d'index
                                .transition(.opacity)
                        }
                    }
                    .frame(width: segmentWidth)
                }
            }
            .clipShape(Capsule())
            .animation(.easeInOut, value: currentIndex)
        }
    }
}

#Preview {
    VStack(spacing: 30) {
        // Exemple avec le deuxième segment actif (le plus long)
        IterationProgressView(iterations: [15, 45, 20], currentIndex: 3)
            .frame(height: 24)
            .padding()
        
        Text("Segment 2 actif (45s sur 80s total)")
            .font(.caption)
    }
}
