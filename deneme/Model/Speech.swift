import SwiftUI

struct Speech: Identifiable {
    let id = UUID()
    var text: String
    var position: CGPoint
    var opacity: Double = 1.0
}
