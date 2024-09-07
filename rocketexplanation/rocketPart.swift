import SwiftUI

enum RocketPart: String, CaseIterable {
    case engine, fuelTank, bodytube, fins, noseCone
    
    var displayName: String {
        switch self {
        case .engine: return "Engine"
        case .fuelTank: return "Fuel Tank"
        case .bodytube: return "Body Tube"
        case .fins: return "Fins"
        case .noseCone: return "Nose Cone"
        }
    }
    
    var description: String {
        switch self {
        case .engine: return "The engine is the powerhouse of the rocket, driving it skyward through immense thrust. It burns propellants to generate the required thrust for lift-off and propulsion."
        case .fuelTank: return "The fuel tank houses propellants that feed the rocket's engines. It must be designed to withstand extreme pressures and temperatures encountered during flight."
        case .bodytube: return "The body tube forms the main structure of the rocket, providing support for other components such as the payload and engine. It also houses the propellant tanks and provides aerodynamic stability."
        case .fins: return "Fins are aerodynamic surfaces attached to the rocket's body tube. They provide stability and control by stabilizing the rocket's flight trajectory and minimizing aerodynamic drag."
        case .noseCone: return "The nose cone is located at the front of the rocket and serves to reduce aerodynamic drag by piercing through the atmosphere. It also houses instruments and payload components.\n Nose Cones can come in many different shapes from elliptical, parabolic, ogive, and conical."
        }
    }}
