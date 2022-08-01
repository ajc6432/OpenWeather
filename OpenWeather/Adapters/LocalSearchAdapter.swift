import CoreLocation
import MapKit
import Combine

protocol LocalSearchAdapterProtocol {
    func performLocalSearch(withQuery query: String) -> AnyPublisher<[Place], Never>
}

struct LocalSearchAdapter: LocalSearchAdapterProtocol {
    func performLocalSearch(withQuery query: String) -> AnyPublisher<[Place], Never> {
        let pub = PassthroughSubject<[Place], Never>()

        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = query

        MKLocalSearch(request: searchRequest).start { response, error in

            // purposely ignore errors for better user experience in MKLocalSearch

            if let response = response {
                pub.send(response.mapItems.map { Place(name: $0.placemark.name ?? "",
                                                       address: $0.fullAddress,
                                                       city: $0.city ?? "",
                                                       latitude: $0.placemark.coordinate.latitude,
                                                       longitude: $0.placemark.coordinate.longitude) })
            }

        }

        return pub.eraseToAnyPublisher()
    }
}
