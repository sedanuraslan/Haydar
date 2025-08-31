import SwiftUI

class MovementManager {
    static let shared = MovementManager()
    
    func startMovement(
        position: Binding<CGPoint>,
        velocity: Binding<CGPoint>,
        stepCounter: Binding<Int>,
        footprints: Binding<[Footprint]>,
        isMoving: Binding<Bool>,
        boxSize: CGFloat,
        screenSize: CGSize
    ) {
        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            var newX = position.wrappedValue.x + velocity.wrappedValue.x
            var newY = position.wrappedValue.y + velocity.wrappedValue.y

            if newX < boxSize/2 || newX > screenSize.width - boxSize/2 {
                velocity.wrappedValue.x *= -1
                newX = max(boxSize/2, min(screenSize.width - boxSize/2, newX))
            }
            if newY < boxSize/2 || newY > screenSize.height - boxSize/2 {
                velocity.wrappedValue.y *= -1
                newY = max(boxSize/2, min(screenSize.height - boxSize/2, newY))
            }

            stepCounter.wrappedValue += 1
            if stepCounter.wrappedValue % 30 == 0 {
                let footprint = Footprint(position: position.wrappedValue)
                footprints.wrappedValue.append(footprint)
                withAnimation(.easeOut(duration: 3)) {
                    if let index = footprints.wrappedValue.firstIndex(where: { $0.id == footprint.id }) {
                        footprints.wrappedValue[index].opacity = 0
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    footprints.wrappedValue.removeAll { $0.id == footprint.id }
                }
            }

            velocity.wrappedValue.x += CGFloat.random(in: -0.05...0.05)
            velocity.wrappedValue.y += CGFloat.random(in: -0.05...0.05)

            withAnimation(.linear(duration: 0.016)) {
                position.wrappedValue = CGPoint(x: newX, y: newY)
            }
        }
    }
}
