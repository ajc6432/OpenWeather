import Foundation

class HomeViewModel: ObservableObject {
    // MARK: - Accessible Properties
    @Published private(set) var savedPlaces: [Place] = [] // Could choose to load from LocalStorage like CoreData or load from an API

    var showEmptyView: Bool {
        savedPlaces.isEmpty
    }

    func saveNewPlace(place: Place) {
        savedPlaces.append(place)
    }

    func delete(at offsets: IndexSet) {
        savedPlaces.remove(atOffsets: offsets)
    }
}
