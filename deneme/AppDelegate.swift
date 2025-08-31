import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
        let boxSize: CGFloat = 75
        let screen = NSScreen.main!
        let startX = CGFloat.random(in: boxSize/2 ... screen.frame.width - boxSize/2)
        let startY = CGFloat.random(in: boxSize/2 ... screen.frame.height - boxSize/2)

        window = NSWindow(
            contentRect: NSScreen.main!.frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.isOpaque = false
        window.backgroundColor = .clear
        window.level = .floating
        window.hasShadow = false
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]

        window.contentView = NSHostingView(rootView: ContentView(boxSize: boxSize))
        window.makeKeyAndOrderFront(nil)
    }
}
