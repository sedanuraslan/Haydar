import SwiftUI

struct Heart: Identifiable {
    let id = UUID()
    var position: CGPoint
    var opacity: Double = 1.0
}
