import SwiftUI

// A view for displaying a tutorial to the user.
struct TutorialView: View {
    // State variable to toggle between the introduction and the next page of the tutorial.
    @State private var showNextPage = false
    // Closure to be called when the tutorial is dismissed.
    var onDismiss: () -> Void
    
    var body: some View {
        VStack {
            if showNextPage {
                // Content for the second page of the tutorial.
                Text("Customize Your Rocket")
                    .font(.title2) // Sets the font size and style.
                    .bold() // Makes the text bold.
                    .padding() // Adds padding around the text for spacing.
                
                // Detailed instructions for customizing the rocket, combining text and an icon.
                (Text("Begin your rocket assembly by dragging parts onto the canvas. Customize each component's color with a tap on ") +
                 Text(Image(systemName: "paintbrush")) + // Includes an icon inline with the text.
                 Text(", or tap a part's name to explore detailed information. Every piece plays a vital role in the rocket's launch success. Below is an example showcasing a fully assembled rocket, incorporating all essential parts."))
                .padding() // Adds padding around the text for better readability.
                
                // Displays an example image of a rocket design.
                Image("rocketDesignExample") // Image name should match an asset in your project.
                    .resizable() // Allows the image to be resized.
                    .aspectRatio(contentMode: .fit) // Keeps the aspect ratio of the image.
                    .frame(width: 250, height: 250) // Sets the size of the image.
                
                // Credits for the rocket design example.
                Text("Engine was designed by HumanIndustries on TinkerCad.")
                    .font(.footnote) // Sets the font size to footnote for smaller text.
                    .frame(maxWidth: .infinity, alignment: .leading) // Aligns the text to the left.
                
                // Button to dismiss the tutorial.
                Button("Done") {
                    onDismiss() // Calls the provided closure to dismiss the tutorial.
                }
                .padding() // Adds padding around the button for spacing.
            } else {
                // Content for the first page of the tutorial.
                Text("Welcome to Rocket Design!")
                    .font(.title) // Sets the font size and style.
                    .bold() // Makes the text bold.
                
                // Brief introduction to the app's functionality.
                Text("Drag and drop parts onto the canvas to build your rocket.")
                    .padding() // Adds padding around the text for spacing.
                
                // Button to navigate to the next page of the tutorial.
                Button("Next") {
                    showNextPage = true // Changes the state to show the next page.
                }
                .padding() // Adds padding around the button for spacing.
            }
        }
        .frame(width: 400, height: showNextPage ? 600 : 300) // Dynamically adjusts the frame size based on the content.
        .background(Color.black.opacity(0.8)) // Sets the background color and opacity.
        .foregroundColor(.white) // Sets the text color to white for contrast.
        .cornerRadius(20) // Rounds the corners of the background.
        .padding() // Adds padding around the entire view for spacing from other UI elements.
    }
}
