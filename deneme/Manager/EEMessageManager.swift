import SwiftUI
import AppKit

class EEMessageManager {
    static let shared = EEMessageManager()
    
    func eeWritesMessage(repeatTwiceIfUnloved: Bool = false) {
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent("pet_message.txt")
        let messages = ["Benimle ilgilen!", "Hadi oyun oynayalım!", "Selam! 😸", "Buradayım!"]
        let message = messages.randomElement()!
        try? message.write(to: fileURL, atomically: true, encoding: .utf8)
        
        if let pagesURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: "com.apple.iWork.Pages") {
            NSWorkspace.shared.open([fileURL], withApplicationAt: pagesURL, configuration: NSWorkspace.OpenConfiguration(), completionHandler: nil)
        }
        
        if repeatTwiceIfUnloved {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.eeWritesMessage(repeatTwiceIfUnloved: false)
            }
        }
    }
    
    func scheduleEEMessageCheck(usingKnife: Binding<Bool>, loveCount: Binding<Int>) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 300) {
            if loveCount.wrappedValue < 10 {
                usingKnife.wrappedValue = true
                loveCount.wrappedValue = 0
                self.eeWritesMessage(repeatTwiceIfUnloved: true)
            }
        }
    }
}
