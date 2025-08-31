import SwiftUI
import Foundation

class HeartRainManager {
    static let shared = HeartRainManager()
    
    private init() {}
    
    func triggerHeartRain(hearts: Binding<[Heart]>, screenSize: CGSize) {
        for _ in 0..<100 {
            let delay = Double.random(in: 0...5)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                let randomX = CGFloat.random(in: 0...screenSize.width)
                let startY: CGFloat = -20
                let endY = screenSize.height + 20
                
                let heart = Heart(position: CGPoint(x: randomX, y: startY))
                hearts.wrappedValue.append(heart)
                
                let fallDuration = Double.random(in: 3...6)
                withAnimation(.linear(duration: fallDuration)) {
                    if let index = hearts.wrappedValue.firstIndex(where: { $0.id == heart.id }) {
                        hearts.wrappedValue[index].position.y = endY
                        hearts.wrappedValue[index].opacity = 0
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + fallDuration) {
                    hearts.wrappedValue.removeAll { $0.id == heart.id }
                }
            }
        }
    }
}
