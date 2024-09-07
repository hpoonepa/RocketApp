import SwiftUI

// A SwiftUI view that displays detailed information about a specific rocket part.
struct DetailView: View {
    // The `part` property holds the specific instance of `RocketPart` to display.
    let part: RocketPart
    
    var body: some View {
        // Vertical stack to organize content linearly on the screen.
        VStack(alignment: .leading) {
            // Displays the name of the rocket part with semibold font weight.
            Text(part.displayName)
                .fontWeight(.semibold)
            // Displays the description of the rocket part.
            // The font is set to caption size for a subtler appearance, and the text color is black.
            Text(part.description)
                .font(.caption)
                .foregroundColor(.black)
        }
        // Adds vertical padding to create some space around the VStack content.
        .padding(.vertical, 4)
    }
}
