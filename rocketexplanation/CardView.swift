import SwiftUI

// A reusable CardView component designed to display content within a stylized card.
// This component is generic and can host any content that conforms to the View protocol.
struct CardView<Content: View>: View {
    // Title for the card, displayed at the top.
    let title: String
    // The content of the card, which is determined by the caller and can be any SwiftUI View.
    let content: Content
    
    // Initializer for the card view which takes a title and a content view.
    // The @ViewBuilder attribute allows for dynamic view content to be passed in.
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        // Vertical stack to align the title and the content.
        VStack(alignment: .leading, spacing: 10) {
            // Displays the title of the card with styling.
            Text(title)
                .font(.headline) // Sets the font for the title.
                .foregroundColor(.blue) // Sets the title color.
                .padding(.bottom, 2) // Adds a little space between the title and the content.
            
            // The content of the card, defined by the caller of CardView.
            content
        }
        .padding() // Adds padding around the content of the card.
        // Sets the background of the card to a linear gradient from white to light gray.
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(12) // Rounds the corners of the card.
        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 2) // Applies a shadow for depth.
        .padding(.horizontal) // Adds horizontal padding outside the card.
        .padding(.bottom, 8) // Adds a little more padding at the bottom for spacing between cards if stacked.
    }
}
