import SwiftUI

struct SpeechBubble: View {
    let speech: Speech

    var body: some View {
        Text(speech.text)
            .font(.system(size: 14))
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.8))
                    .shadow(radius: 2)
            )
            .position(speech.position)
            .opacity(speech.opacity)
    }
}
