import SwiftUI
//Model for each rocket part
struct RocketPartModel: Identifiable {
    let id = UUID()
    var imageNameBase: String // Base name for the image
    let partName: String
    let information: String
    var size: CGSize
    var selectedColor: String = "blue" // Default or initial color
    var colorOptions: [String]
    // Property to compute the image name based on the selected color
    var imageName: String {
        return "\(imageNameBase)\(selectedColor)"
    }
    

}
