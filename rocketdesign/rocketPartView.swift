import SwiftUI
import UniformTypeIdentifiers

// A view component for displaying and interacting with a rocket part.
struct RocketPartView: View {
    // Binding to the RocketPartModel, allowing this view to update as the model changes.
    @Binding var part: RocketPartModel
    // State variable to control the visibility of the color picker.
    @State private var showingColorPicker = false
    // State variable to control the visibility of the information popup for the rocket part.
    @State private var showingInfoPopup = false // State to control info popup visibility
    
    var body: some View {
        VStack {
            HStack {
                // Button to display additional information about the part.
                Button(action: {
                    showingInfoPopup = true // Triggers the visibility of the information popup.
                }) {
                    Text(part.partName) // Displays the name of the rocket part.
                        .font(.headline) // Sets the font style for the part name.
                        .foregroundColor(.white) // Sets the text color to white for contrast.
                }
                .padding(.horizontal, 10) // Adds horizontal padding to the button for spacing.
                
                Spacer() // Pushes the button and the icon apart.
                
                // Button to show the color picker for this part.
                Button(action: {
                    showingColorPicker = true // Triggers the visibility of the color picker.
                }) {
                    Image(systemName: "paintbrush") // Icon for the color picker button.
                        .foregroundColor(.white) // Sets the icon color to white for visibility.
                }
                .padding(.horizontal, 10) // Adds horizontal padding to the button for spacing.
            }
            
            // Displays the image associated with the rocket part.
            Image(part.imageName) // Uses the imageName property to fetch the correct image.
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 80)
                .cornerRadius(10) // Rounds the corners of the image for a smoother look.
                .onDrag {
                    // Enables drag-and-drop functionality for this part, using the imageName as the item provider.
                    return NSItemProvider(object: part.imageName as NSString)
                }
        }
        .frame(width: 160) // Sets a fixed width for the entire rocket part view.
        .background(Color.gray.opacity(0.5)) // Sets a semi-transparent gray background to highlight the part.
        .cornerRadius(10) // Rounds the corners of the background for a cohesive look.
        .overlay(
            // Conditionally displays an information popup for the rocket part.
            Group {
                if showingInfoPopup {
                    CustomPopupView(partName: part.partName, information: part.information) // The custom popup view with part details.
                        .onTapGesture {
                            showingInfoPopup = false // Hides the popup when tapped.
                        }
                        .transition(.scale.combined(with: .opacity)) // Defines the animation for showing and hiding the popup.
                        .zIndex(1) // Ensures the popup appears above other UI elements.
                }
            }
        )
        .sheet(isPresented: $showingColorPicker) {
            // Presents a color picker sheet when the color picker button is tapped.
            ColorPickerPad(part: $part, isPresented: $showingColorPicker) // Passes bindings to the color picker pad.
        }
        
    }
}
