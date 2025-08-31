import SwiftUI
import Combine

class FoodManager: ObservableObject {
    static let shared = FoodManager()
    
    @Published var foods: [Food] = []

    private init() {}

    func spawnFood(screenSize: CGSize, around position: CGPoint) {
        foods.removeAll()
        let count = Int.random(in: 5...10)
        for _ in 0..<count {
            let x = CGFloat.random(in: 50...(screenSize.width - 50))
            let y = CGFloat.random(in: 50...(screenSize.height - 50))
            let newFood = Food(
                imageName: ["food","food1","food2"].randomElement()!,
                position: CGPoint(x: x, y: y)
            )
            foods.append(newFood)
        }
    }

    func eatFood(_ food: Food) {
        if let index = foods.firstIndex(where: { $0.id == food.id }) {
            foods.remove(at: index)
        }
    }

    func checkFoodCollision(characterPosition: CGPoint) {
        foods.removeAll { food in
            let distance = hypot(food.position.x - characterPosition.x,
                                 food.position.y - characterPosition.y)
            return distance < 80
        }
    }
}

