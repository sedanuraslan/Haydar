import SwiftUI

struct FoodsView: View {
    @ObservedObject var foodManager: FoodManager
    @Binding var characterPosition: CGPoint
    let characterSize: CGFloat

    var body: some View {
        ForEach(foodManager.foods) { food in
            Image(food.imageName)
                .resizable()
                .frame(width: 40, height: 40)
                .position(food.position)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if let index = foodManager.foods.firstIndex(where: { $0.id == food.id }) {
                                foodManager.foods[index].position = value.location
                            }
                        }
                        .onEnded { value in
                            let distance = hypot(value.location.x - characterPosition.x,
                                                 value.location.y - characterPosition.y)
                            if distance < characterSize / 2 {
                                foodManager.eatFood(food)
                            }
                        }
                )
        }
    }
}
