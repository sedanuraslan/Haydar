import SwiftUI

struct Footprint: Identifiable {
    let id = UUID()
    var position: CGPoint
    var opacity: Double = 1.0
}
