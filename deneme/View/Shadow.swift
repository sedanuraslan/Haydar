import SwiftUI

extension View {
    func lightShadow() -> some View {
        self.shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)
    }
}
