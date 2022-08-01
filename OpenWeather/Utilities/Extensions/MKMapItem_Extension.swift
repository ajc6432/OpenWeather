import MapKit

extension MKMapItem {
    var latitude: Double {
        placemark.coordinate.latitude
    }

    var longitude: Double {
        placemark.coordinate.longitude
    }

    var streetAddress: String {
        if let number = placemark.subThoroughfare,
           let street = placemark.thoroughfare {
            return [number, street].joined(separator: " ")
        }

        return placemark.thoroughfare ?? ""
    }

    var city: String? {
        placemark.locality
    }

    var state: String? {
        placemark.administrativeArea
    }

    var fullAddress: String? {
        if let city = city, let state = state {
            return [streetAddress, "\(city), \(state)"].joined(separator: "\n")
        }
        return nil
    }

    var displayName: String {
        placemark.name ?? placemark.title ?? streetAddress
    }
}
