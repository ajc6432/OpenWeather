import Foundation

struct Place: Identifiable, Equatable {
    let id: String = UUID().uuidString
    let name: String
    let address: String?
    let city: String
    let latitude: Double
    let longitude: Double
}
