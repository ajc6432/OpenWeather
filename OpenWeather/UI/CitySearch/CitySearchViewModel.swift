import Foundation
import Combine

class CitySearchViewModel: ObservableObject {
    // MARK: - Accessible Properties
    @Published private(set) var places: [Place] = []

    // MARK: - Injections
    private let localSearchAdapter: LocalSearchAdapterProtocol

    // MARK: - Local Properties
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()

    init(localSearchAdapter: LocalSearchAdapterProtocol = LocalSearchAdapter()) {
        self.localSearchAdapter = localSearchAdapter
    }

    func searchForCity(named name: String) {
        // intentionally ignoring errors from MKLocalSearch for better user experience
        localSearchAdapter.performLocalSearch(withQuery: name)
            .sink(receiveValue: { [weak self] results in
                self?.places = results
            })
            .store(in: &subscriptions)
    }
}
