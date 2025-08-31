import SwiftUI

struct CharacterView: View {
    @Binding var position: CGPoint
    let boxSize: CGFloat
    let currentImage: String
    @Binding var hearts: [Heart]
    @Binding var loveCount: Int
    @Binding var usingKnife: Bool
    let screenSize: CGSize
    @StateObject private var specialModeManager = SpecialModeManager()
    @ObservedObject var foodManager = FoodManager.shared

    var body: some View {
        Image(currentImage)
            .resizable()
            .frame(width: boxSize, height: boxSize)
            .position(position)
            .lightShadow()
            .contextMenu {
                Button("Sürpriz") {
                    HeartRainManager.shared.triggerHeartRain(hearts: $hearts, screenSize: screenSize)
                }
                Button("Besle Beni") {
                    foodManager.spawnFood(screenSize: screenSize, around: position)
                }
                Button("Fareyi Ye") {
                    specialModeManager.startSpecialMode(
                        characterPosition: { position },
                        boxSize: boxSize,
                        duration: 3.0
                    )
                 }
            }
            .onTapGesture {
                let heart = Heart(position: position)
                hearts.append(heart)
                withAnimation(.easeOut(duration: 2)) {
                    if let index = hearts.firstIndex(where: { $0.id == heart.id }) {
                        hearts[index].opacity = 0
                        hearts[index].position.y -= 50
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    hearts.removeAll { $0.id == heart.id }
                }
                loveCount += 1
                
                if usingKnife && loveCount >= 10 {
                    usingKnife = false
                    loveCount = 0
                }
            }
            .onChange(of: position) { newPos in
                foodManager.checkFoodCollision(characterPosition: newPos)
            }
    }
}
