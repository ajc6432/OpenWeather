import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel

    @State private var citySearchIsPresented = false
    @State private var newPlace: Place?

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.showEmptyView {
                    Text("Search to show weather forecasts here!")
                }

                List {
                    ForEach(viewModel.savedPlaces) { place in
                        Text(place.city)
                    }
                    .onDelete { indexSet in
                        viewModel.delete(at: indexSet)
                    }
                }
                .listStyle(.plain)
            }
            .padding()
            .navigationTitle("OpenWeather")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        citySearchIsPresented = true
                    } label: {
                        Image(systemName: Asset.magnifyingGlass.rawValue)
                    }
                }
            }
            .sheet(isPresented: $citySearchIsPresented) {
                CitySearchView(isSearching: $citySearchIsPresented,
                               newCity: $newPlace)
                .environmentObject(CitySearchViewModel())
            }
            .onChange(of: newPlace) { newValue in
                if let ugh = newValue {
                    viewModel.saveNewPlace(place: ugh)
                    newPlace = nil
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
