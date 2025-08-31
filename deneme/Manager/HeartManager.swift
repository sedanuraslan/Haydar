import SwiftUI

class HeartManager {
    static let shared = HeartManager()

    func spawnHeart(hearts: Binding<[Heart]>, position: CGPoint) {
        let heart = Heart(position: position)
        hearts.wrappedValue.append(heart)

        withAnimation(.easeOut(duration: 2)) {
            if let index = hearts.wrappedValue.firstIndex(where: { $0.id == heart.id }) {
                hearts.wrappedValue[index].opacity = 0
                hearts.wrappedValue[index].position.y -= 50
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            hearts.wrappedValue.removeAll { $0.id == heart.id }
        }
    }

    func triggerHeartRain(hearts: Binding<[Heart]>) {
        for _ in 0..<100 {
            let delay = Double.random(in: 0...5)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                let randomX = CGFloat.random(in: 0...800)
                let startY: CGFloat = -20
                let endY: CGFloat = 600 + 20

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
