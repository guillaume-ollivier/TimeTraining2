import SwiftUI

struct TimelineSelector: View {
    let nbIteration: Int
    @Binding var isFirstActive: Bool
    @Binding var isMiddleActive: Bool
    @Binding var isLastActive: Bool

    var body: some View {
        HStack(spacing: 0) { // On colle les segments pour le look "segmenté"
            SegmentButton(title: "\(nbIteration>0 ? "1":"-")", isActive: $isFirstActive, position: .first)
            
            // Séparateur vertical discret
            Divider().frame(height: 20)
            
            SegmentButton(title: "\(nbIteration==3 ? "2":  (nbIteration==4 ? "2, 3" : ( nbIteration>4 ? "2...\(nbIteration-1)" : "-")))", isActive: $isMiddleActive, position: .middle)
            
            Divider().frame(height: 20)
            
            SegmentButton(title: "\(nbIteration>0 ? String(nbIteration):"-")", isActive: $isLastActive, position: .last)
        }
        .frame(height: 44) // Hauteur standard d'une cellule iOS
        .background(Color(UIColor.tertiarySystemFill)) // Fond gris clair type système
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

enum SegmentPosition {
    case first, middle, last
}

struct SegmentButton: View {
    let title: String
    @Binding var isActive: Bool
    let position: SegmentPosition
    
    var iconName: String {
        switch position {
        case .first:  return "arrow.left.to.line"
        case .middle: return "arrow.left.and.line.vertical.and.arrow.right"
        case .last:   return "arrow.right.to.line"
        }
    }

    var body: some View {
        Button(action: {
            withAnimation(.snappy(duration: 0.2)) {
                isActive.toggle()
            }
        }) {
            VStack(spacing: 2) {
                Image(systemName: iconName)
                    .font(.system(size: 14, weight: .bold))
                
                Text(title)
                    .font(.system(size: 10, weight: .medium, design: .rounded))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // L'astuce : si actif, on colorise le fond ou le texte
            .background(isActive ? Color.blue : Color.clear)
            .foregroundColor(isActive ? .white : .secondary)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle()) // Évite le flash gris au clic du bouton
    }
}

// Preview mis à jour
struct TimelineSelector_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            Section(header: Text("Réglages des étapes")) {
                TimelineSelector(
                    nbIteration: 6,
                    isFirstActive: .constant(true),
                    isMiddleActive: .constant(false),
                    isLastActive: .constant(true)
                )
            }
        }
    }
}
