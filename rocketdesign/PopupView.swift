import SwiftUI

// Defines a view for displaying a popup with information about a rocket part or similar.
struct CustomPopupView: View {
    // The name of the part to be displayed at the top of the popup.
    var partName: String
    // The descriptive or informative text about the part to be displayed under the part name.
    var information: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Displays the part name with specific font, weight, and color settings.
            Text(partName)
                .font(.footnote) // Uses the footnote font size for a compact appearance.
                .fontWeight(.bold) // Makes the part name bold to stand out.
                .foregroundColor(.white) // Sets the text color to white for contrast.
            
            Divider() // Adds a visual divider between the part name and the information.
            
            // Displays the informational text with specific font and color settings.
            Text(information)
                .font(.footnote) // Uses the footnote font size for consistency with the part name.
                .foregroundColor(.white) // Sets the text color to white for readability.
                .fixedSize(horizontal: false, vertical: true) // Allows the text to wrap and expand vertically.
        }
        .padding() // Adds padding around the VStack content for spacing.
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)) // Sets a linear gradient background.
        .cornerRadius(10) // Rounds the corners of the popup.
        .shadow(radius: 5) // Applies a shadow for a 3D effect.
        .padding(.top, 10) // Adds additional padding at the top for spacing from other UI elements.
        .frame(width: 150) // Sets a fixed width for the popup.
    }
}
