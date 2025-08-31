import SwiftUI

struct SpeechesView: View {
    @Binding var speeches: [Speech]

    var body: some View {
            ForEach(speeches) { speech in
                SpeechBubble(speech: speech)
            }
        
    }
}
