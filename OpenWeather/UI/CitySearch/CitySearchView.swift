import SwiftUI

struct CitySearchView: View {
    @EnvironmentObject var viewModel: CitySearchViewModel

    @Binding var isSearching: Bool
    @Binding var newCity: Place?

    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.places) { place in
                    SearchResultView(place: place)
                        .padding()
                        .onTapGesture {
                            isSearching = false
                            newCity = place
                        }
                }
                .navigationTitle("Choose a City")
                .searchable(text: $searchText)
                .onChange(of: searchText) { newValue in
                    viewModel.searchForCity(named: newValue)
                }
            }
        }
    }
}

extension CitySearchView {
    struct SearchResultView: View {
        let place: Place

        var body: some View {
            VStack(alignment: .leading) {
                Text(place.name)
                    .font(.headline)

                if let address = place.address {
                    Text(address)
                        .font(.subheadline)
                }
            }
        }
    }
}

struct CitySearchView_Previews: PreviewProvider {
    static var previews: some View {
        CitySearchView(isSearching: .constant(true), newCity: .constant(nil))
    }
}
