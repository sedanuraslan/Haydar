import SwiftUI

class SpeechManager {
    static let shared = SpeechManager()
    
    func scheduleRandomSpeech(
        speeches: Binding<[Speech]>,
        position: Binding<CGPoint>,
    ) {
        let interval = Double.random(in: 5...15)
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.spawnSpeech(speeches: speeches, position: position)
            self.scheduleRandomSpeech(speeches: speeches, position: position)
        }
    }
    
    func spawnSpeech(speeches: Binding<[Speech]>, position: Binding<CGPoint>) {
        let messages = ["Merhaba!", "Sevildim!", "Uykum var...", "Nasılsın?", "Pat pat!"]
        let speech = Speech(text: messages.randomElement()!, position: position.wrappedValue)
        speeches.wrappedValue.append(speech)
        
        withAnimation(.easeOut(duration: 2)) {
            if let index = speeches.wrappedValue.firstIndex(where: { $0.id == speech.id }) {
                speeches.wrappedValue[index].opacity = 0
                speeches.wrappedValue[index].position.y -= 20
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            speeches.wrappedValue.removeAll { $0.id == speech.id }
        }
    }
}
