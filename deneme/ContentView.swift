import SwiftUI
import Foundation
import AppKit

struct ContentView: View {
    let boxSize: CGFloat
    let screenSize = NSScreen.main?.frame.size ?? CGSize(width: 800, height: 600)

    @State private var position: CGPoint = .zero
    @State private var velocity: CGPoint = .zero
    @State private var stepCounter = 0
    @State private var isMoving = true
    @State private var isFalling = false
    @State private var fallFrameIndex = 0
    @State private var loveCount = 0
    @State private var usingKnife = false

    @State private var footprints: [Footprint] = []
    @State private var hearts: [Heart] = []
    @State private var speeches: [Speech] = []
    @StateObject private var foodManager = FoodManager.shared

    var currentImage: String {
        if isFalling {
            let fallFrames = ["fall1", "fall2", "fall3", "fall4"]
            return fallFrames[min(fallFrameIndex, fallFrames.count - 1)]
        } else if usingKnife {
            return velocity.x >= 0 ? (stepCounter % 20 < 10 ? "knife1" : "knife2") :
                                     (stepCounter % 20 < 10 ? "knife3" : "knife4")
        } else {
            return velocity.x >= 0 ? (stepCounter % 20 < 10 ? "pet" : "pet1") :
                                     (stepCounter % 20 < 10 ? "pet2" : "pet3")
        }
    }

    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()

            FootprintsView(footprints: $footprints)
            SpeechesView(speeches: $speeches)

            CharacterView(
                position: $position,
                boxSize: boxSize,
                currentImage: currentImage,
                hearts: $hearts,
                loveCount: $loveCount,
                usingKnife: $usingKnife,
                screenSize: screenSize
            )

            HeartsView(hearts: $hearts)
            FoodsView(
                foodManager: foodManager,
                characterPosition: $position,
                characterSize: boxSize
            )
        }
        .onAppear {
            startRandomPosition()
            startMovement()
            scheduleRandomSpeech()
            EEMessageManager.shared.scheduleEEMessageCheck(usingKnife: $usingKnife, loveCount: $loveCount)
        }
    }

    func startRandomPosition() {
        position = CGPoint(
            x: CGFloat.random(in: boxSize/2...screenSize.width - boxSize/2),
            y: CGFloat.random(in: boxSize/2...screenSize.height - boxSize/2)
        )
        velocity = CGPoint(x: CGFloat.random(in: -1.2...1.2), y: CGFloat.random(in: -1.2...1.2))
    }

    @State private var lastFallDate = Date.distantPast
    let fallCooldown: TimeInterval = 600

    func startMovement() {
        MovementManager.shared.startMovement(
            position: $position,
            velocity: $velocity,
            stepCounter: $stepCounter,
            footprints: $footprints,
            isMoving: $isMoving,
            boxSize: boxSize,
            screenSize: screenSize
        )

        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
            let now = Date()
            if !isFalling &&
               now.timeIntervalSince(lastFallDate) > fallCooldown &&
               Int.random(in: 0..<3) == 0 {
                triggerFall()
                lastFallDate = now
            }
        }
    }

    func scheduleRandomSpeech() {
        SpeechManager.shared.scheduleRandomSpeech(
            speeches: $speeches,
            position: $position
        )
    }

    func triggerFall() {
        guard !isFalling else { return }
        isFalling = true
        isMoving = false
        fallFrameIndex = 0

        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            fallFrameIndex += 1
            if fallFrameIndex >= 4 {
                timer.invalidate()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            isFalling = false
            isMoving = true
        }
    }
}
