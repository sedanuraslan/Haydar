import SwiftUI

struct Food: Identifiable {
    let id = UUID()
    let imageName: String
    var position: CGPoint
}
