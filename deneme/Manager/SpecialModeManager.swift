import SwiftUI
import AppKit

class SpecialModeManager: ObservableObject {
    var timer: Timer?

    func startSpecialMode(characterPosition: @escaping () -> CGPoint, boxSize: CGFloat, duration: Double = 3.0) {
        timer?.invalidate()
        
        let startMouse = NSEvent.mouseLocation
        let steps = Int(duration / 0.01)
        var currentStep = 0

        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { t in
            currentStep += 1
            let fraction = Double(currentStep) / Double(steps)

            let charPos = characterPosition()
            let target = CGPoint(x: charPos.x + boxSize/2, y: charPos.y + boxSize/2)

            let newX = startMouse.x + (target.x - startMouse.x) * fraction
            let newY = startMouse.y + (target.y - startMouse.y) * fraction

            CGWarpMouseCursorPosition(CGPoint(x: newX, y: newY))

            if currentStep >= steps {
                t.invalidate()
                
                CGDisplayHideCursor(CGMainDisplayID())
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    CGDisplayShowCursor(CGMainDisplayID())
                }
            }
        }
    }
}
