import SwiftUI

struct HeartsView: View {
    @Binding var hearts: [Heart]
    
    var body: some View {
        ForEach(hearts) { heart in
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
                .font(.system(size: 20))
                .position(heart.position)
                .opacity(heart.opacity)
        }
    }
}
