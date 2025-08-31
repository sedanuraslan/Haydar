import SwiftUI

struct FootprintsView: View {
    @Binding var footprints: [Footprint]
    
    var body: some View {
       
            ForEach(footprints) { footprint in
                Circle()
                    .fill(Color.black)
                    .frame(width: 6, height: 6)
                    .position(footprint.position)
                    .opacity(footprint.opacity)
            
        }
    }
}
