import SwiftUI

// Defines a view for picking a color for a specific rocket part.
struct ColorPickerPad: View {
    // Binding to the RocketPartModel to update the selected color directly.
    @Binding var part: RocketPartModel
    // Binding to control the presentation state of this color picker view.
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            // Horizontal stack for the dismiss button.
            HStack {
                // Button to dismiss the color picker.
                Button(action: {
                    isPresented = false // Action to close the color picker sheet.
                }) {
                    Image(systemName: "x.circle.fill") // System image for the dismiss button.
                        .padding() // Adds padding around the image for better tapability.
                        .foregroundColor(.white) // Sets the foreground color to white.
                        .background(Color.red) // Sets the background color to red for visibility.
                        .cornerRadius(10) // Rounds the corners of the button background.
                }
                Spacer() // Pushes the button to the leading edge.
            }
            .padding(.bottom, 5) // Adds padding below the HStack.
            
            // Text prompting user to select a color for the part.
            Text("Select a color for \(part.partName)")
                .font(.headline) // Sets the font style to headline for emphasis.
            
            // Lists color options for the part.
            ForEach(part.colorOptions, id: \.self) { colorOption in
                // Button for each color option.
                Button(action: {
                    part.selectedColor = colorOption // Updates the selected color of the part.
                    isPresented = false // Dismisses the color picker after selection.
                }) {
                    Text(colorOption.capitalized) // Capitalizes the color option for display.
                        .padding() // Adds padding around the text for better appearance.
                        .foregroundColor(.white) // Sets the text color to white for contrast.
                        .background(Color.blue) // Sets the background color to blue.
                        .cornerRadius(10) // Rounds the corners of the button.
                }
                .padding(4) // Adds padding around each button for spacing.
            }
        }
        .padding() // Adds padding inside the VStack for spacing.
        .background(Color.gray.opacity(0.9)) // Sets a semi-transparent gray background for the picker.
        .cornerRadius(15) // Rounds the corners of the entire color picker view.
        .padding() // Adds padding around the color picker view for spacing from the edges.
        .frame(width:300) // Sets a fixed width for the color picker view.
    }
}
